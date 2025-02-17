//
//  RemoteContentViewModelTest.swift
//  RickAndMortySampleTests
//
//  Created by Dmitrii Zverev on 17/2/2025.
//

import Testing
@testable import RickAndMortySample

struct RemoteContentViewModelTest {

    @Test func apiPathSetsCorrectlIntoViewModel() async throws {
        let testOptions: [ApiPath] = [
            .character(1),
            .characters,
            .episode(1),
            .episodes,
            .location(1),
            .locations
        ]
        let mockConnectionManager = MockNetworkManager()
        for apiPath in testOptions {
            let viewModel = await RemoteContentViewModel(connectionManager: mockConnectionManager, apiPath: apiPath)
            await #expect(viewModel.apiPath == apiPath)
        }
    }

    // MARK: Testing Happy path and correct response type
    @Test func testHappyPath() async throws {
        try await happyPath(apiPath: .characters)
        try await happyPath(apiPath: .character(1))
        try await happyPath(apiPath: .locations)
        try await happyPath(apiPath: .location(1))
        try await happyPath(apiPath: .episodes)
        try await happyPath(apiPath: .episode(1))
    }

    func happyPath(apiPath: ApiPath) async throws {
        let mockConnectionManager = MockNetworkManager()
        let viewModel = await RemoteContentViewModel(connectionManager: mockConnectionManager, apiPath: apiPath)
        await #expect(viewModel.loadingState == .loading(nil))
        await viewModel.fetchData()
        switch await viewModel.loadingState {
        case .loaded(let content):
            switch (content, apiPath) {
            case (.characters(let result), .characters):
                #expect(result.count == 1)
                #expect(result.first?.name == "Toxic Rick")
            case (.character(.example), .character(1)):
                break
            case (.locations(let result), .locations):
                #expect(result.count == 1)
                #expect(result.first?.name == "Earth (C-137)")
            case (.location(.example), .location(1)):
                break
            case (.episodes(let result), .episodes):
                #expect(result.count == 1)
                #expect(result.first?.name == "Pilot")
            case (.episode(.example), .episode(1)):
                break
            default:
                Issue.record("Incorrect response for \(apiPath.name)")
            }
        case .loading:
            Issue.record("Incorrect state")
        case .error(let error):
            Issue.record(error)
        }
    }

    // MARK: Testing API fails
    @Test func testApiFails() async throws {
        try await apiFailsPath(apiPath: .characters)
        try await apiFailsPath(apiPath: .character(1))
        try await apiFailsPath(apiPath: .locations)
        try await apiFailsPath(apiPath: .location(1))
        try await apiFailsPath(apiPath: .episodes)
        try await apiFailsPath(apiPath: .episode(1))
    }

    func apiFailsPath(apiPath: ApiPath) async throws {
        let error = ApiError.invalidResponse
        let mockConnectionManager = MockNetworkManager(error: error)
        let viewModel = await RemoteContentViewModel(connectionManager: mockConnectionManager, apiPath: apiPath)

        await #expect(viewModel.loadingState == .loading(nil))
        await viewModel.fetchData()

        switch await viewModel.loadingState {
        case .loaded, .loading:
            Issue.record("Incorrect loadingState")
        case .error(let loadingStateError):
            guard let stateError = loadingStateError as? ApiError else {
                Issue.record("Unexpected error type")
                return
            }
            #expect(stateError == error)
        }
    }
}
