//
//  MockNetworkManager.swift
//  RickAndMortySample
//
//  Created by Dmitrii Zverev on 17/2/2025.
//

import UIKit
@testable import RickAndMortySample

final class MockNetworkManager: ConnectionManager {
    var error: Error?

    init(error: Error? = nil) {
        self.error = error
    }

    // swiftlint:disable force_cast
    // swiftlint:disable:next cyclomatic_complexity
    func fetch<T>(_ path: RickAndMortySample.ApiPath) async throws -> T where T: Decodable {
        if let error { throw error }
        switch path {
        case .characters:
            guard T.self is [RMCharacter].Type else {
                throw ApiError.decodingFailed
            }
            return [RMCharacter.example] as! T
        case .character:
            guard T.self is RMCharacter.Type else {
                throw ApiError.decodingFailed
            }
            return RMCharacter.example as! T
        case .locations:
            guard T.self is [RMLocation].Type else {
                throw ApiError.decodingFailed
            }
            return [RMLocation.example] as! T
        case .location:
            guard T.self is RMLocation.Type else {
                throw ApiError.decodingFailed
            }
            return RMLocation.example as! T
        case .episodes:
            guard T.self is [RMEpisode].Type else {
                throw ApiError.decodingFailed
            }
            return [RMEpisode.example] as! T
        case .episode:
            guard T.self is RMEpisode.Type else {
                throw ApiError.decodingFailed
            }
            return RMEpisode.example as! T
        }
    }
    // swiftlint:enable force_cast

    func loadData(from request: URLRequest) async throws -> (Data, URLResponse) {
        if let error { throw error }
        let response = URLResponse()
        if let img = UIImage(systemName: "globe")?.jpegData(compressionQuality: 1) {
            return (img, response)
        }
        throw ApiError.decodingFailed
    }

}
