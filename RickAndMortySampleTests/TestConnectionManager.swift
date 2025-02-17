//
//  TestConnectionManager.swift
//  RickAndMortySampleTests
//
//  Created by Dmitrii Zverev on 17/2/2025.
//

import Testing
import Foundation
@testable import RickAndMortySample

struct TestConnectionManager {

    @Test func testIncorrectTypes() async throws {
        let manager = MockNetworkManager()

        await #expect(throws: ApiError.decodingFailed) {
            let _: RMLocation = try await manager.fetch(.characters)
        }
        await #expect(throws: ApiError.decodingFailed) {
            let _: RMLocation = try await manager.fetch(.character(10))
        }
        await #expect(throws: ApiError.decodingFailed) {
            let _: RMLocation = try await manager.fetch(.episode(10))
        }
        await #expect(throws: ApiError.decodingFailed) {
            let _: RMLocation = try await manager.fetch(.episodes)
        }
        await #expect(throws: ApiError.decodingFailed) {
            let _: RMCharacter = try await manager.fetch(.location(10))
        }
        await #expect(throws: ApiError.decodingFailed) {
            let _: RMLocation = try await manager.fetch(.locations)
        }
    }

    @Test func testMockError() async throws {
        let error = ApiError.invalidURL

        let manager = MockNetworkManager(error: error)

        await #expect(throws: error) {
            let _: RMLocation = try await manager.fetch(.characters)
        }
        await #expect(throws: error) {
            let _: RMLocation = try await manager.fetch(.character(10))
        }
        await #expect(throws: error) {
            let _: RMLocation = try await manager.fetch(.episode(10))
        }
        await #expect(throws: error) {
            let _: RMLocation = try await manager.fetch(.episodes)
        }
        await #expect(throws: error) {
            let _: RMCharacter = try await manager.fetch(.location(10))
        }
        await #expect(throws: error) {
            let _: RMLocation = try await manager.fetch(.locations)
        }
    }

    @Test func testCorrectTypes() async throws {
        let manager = MockNetworkManager()
        let _: RMCharacterResponse = try await manager.fetch(.characters)
        let _: RMCharacter = try await manager.fetch(.character(10))
        let _: RMEpisode = try await manager.fetch(.episode(10))
        let _: RMEpisodeResponse = try await manager.fetch(.episodes)
        let _: RMLocation = try await manager.fetch(.location(10))
        let _: RMLocationResponse = try await manager.fetch(.locations)
    }

    @Test func testLoadingImage() async throws {
        let manager = MockNetworkManager()
        guard let ulr = URL(string: "https://google.com") else {
            throw ApiError.invalidURL
        }
        let result = try await manager.loadData(from: URLRequest(url: ulr))
        #expect(result.0 != nil)
    }

    @Test func testFailLoadingImage() async throws {
        let manager = MockNetworkManager(error: ApiError.decodingFailed)
        guard let ulr = URL(string: "https://google.com") else {
            throw ApiError.invalidURL
        }

        await #expect(throws: ApiError.decodingFailed) {
            _ = try await manager.loadData(from: URLRequest(url: ulr))
        }
    }

}
