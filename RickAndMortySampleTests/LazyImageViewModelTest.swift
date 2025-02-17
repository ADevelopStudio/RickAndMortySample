//
//  LazyImageViewModelTest.swift
//  RickAndMortySampleTests
//
//  Created by Dmitrii Zverev on 17/2/2025.
//

import Testing
import Foundation
@testable import RickAndMortySample

struct LazyImageViewModelTest {

    @Test func testHappyPath() async throws {
        let mockConnectionManager = MockNetworkManager()
        let viewModel = await LazyImageViewModel(connectionManager: mockConnectionManager)
        URLCache.shared.removeAllCachedResponses()
        await #expect(viewModel.imageState.index == 0)
        await viewModel.loadImage(from: RMCharacter.example.image)
        await #expect(viewModel.imageState.index == 1)
    }

    @Test func testWrongUrl() async throws {
        let mockConnectionManager = MockNetworkManager()
        let viewModel = await LazyImageViewModel(connectionManager: mockConnectionManager)
        URLCache.shared.removeAllCachedResponses()
        await #expect(viewModel.imageState.index == 0)

        // Loading image from NIL String
        await viewModel.loadImage(from: nil)
        await #expect(viewModel.imageState.index == 2)
        switch await viewModel.imageState {
        case .error(let error):
            if let apiError = error as? ApiError {
                #expect(apiError == .invalidURL)
            } else {
                Issue.record("Incorrect errorType")
            }
        default:
            Issue.record("Incorrect state")
        }

        // Loading image from Empty String
        URLCache.shared.removeAllCachedResponses()
        await viewModel.loadImage(from: "")
        switch await viewModel.imageState {
        case .error(let error):
            if let apiError = error as? ApiError {
                #expect(apiError == .invalidURL)
            } else {
                Issue.record("Incorrect errorType")
            }
        default:
            Issue.record("Incorrect state")
        }
    }

    @Test func testApiIssue() async throws {
        let implantedError = ApiError.decodingFailed
        let mockConnectionManager = MockNetworkManager(error: implantedError)
        let viewModel = await LazyImageViewModel(connectionManager: mockConnectionManager)
        await #expect(viewModel.imageState.index == 0)
        URLCache.shared.removeAllCachedResponses()
        await viewModel.loadImage(from: RMCharacter.example.image)
        await #expect(viewModel.imageState.index == 2)

        switch await viewModel.imageState {
        case .error(let error):
            if let apiError = error as? ApiError {
                #expect(apiError == implantedError)
            } else {
                Issue.record("Incorrect errorType")
            }
        default:
            Issue.record("Incorrect state")
        }
    }

}
