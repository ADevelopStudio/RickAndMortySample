//
//  TestConnectionManager.swift
//  RickAndMortySampleTests
//
//  Created by Dmitrii Zverev on 17/2/2025.
//

import Testing
@testable import RickAndMortySample

struct TestConnectionManager {

    @Test func testIncorrectTypes() async throws {
        let manager = MockNetworkManager()
        await #expect(throws: ApiError.decodingFailed) {
            let _: RMCharacter = try await manager.fetch(.characters)
        }
    }

}
