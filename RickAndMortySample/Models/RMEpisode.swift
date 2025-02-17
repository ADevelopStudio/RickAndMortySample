//
//  RMEpisode.swift
//  RickAndMortySample
//
//  Created by Dmitrii Zverev on 16/2/2025.
//

import Foundation

struct RMEpisodeResponse: Codable {
    var results: [RMEpisode]
}

struct RMEpisode: Codable, Identifiable {

    var id: Int
    var name: String
    var airDate: String
    var episode: String
    private var characters: [String]
    var url: String
    var created: Date
}

extension RMEpisode: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine("RMEpisode\(id)")
    }

    static func == (lhs: RMEpisode, rhs: RMEpisode) -> Bool {
        lhs.id == rhs.id
    }
}

extension RMEpisode {
    var participants: [ApiPath] {
        characters
            .compactMap { ApiPath(pathString: $0) }
            .filter {
                switch $0 {
                case .character: return true
                default: return false
                }
            }
    }
}
