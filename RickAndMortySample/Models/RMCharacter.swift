//
//  RMCharacter.swift
//  RickAndMortySample
//
//  Created by Dmitrii Zverev on 13/2/2025.
//

import Foundation

struct RMCharacterResponse: Codable {
    var results: [RMCharacter]
}

struct RMCharacter: Codable, Identifiable {
    enum Status: String, Codable {
        case alive = "Alive"
        case dead = "Dead"
        case unknown = "unknown"
    }

    var id: Int
    var name: String
    var status: Status?
    var species: String
    var type: String
    var gender: String
    var origin: RMCharacterLocation
    var location: RMCharacterLocation
    var image: String
    private var episode: [String]
    var url: String
    var created: Date
}

extension RMCharacter: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine("RMCharacter\(id)")
    }
    static func == (lhs: RMCharacter, rhs: RMCharacter) -> Bool {
        lhs.id == rhs.id
    }
}

extension RMCharacter {
    var isDead: Bool { status == .dead }
    var shortDescription: String {
        [species, gender, type]
            .filter { !$0.isEmpty }
            .joined(separator: ", ")
    }
    var episodes: [ApiPath] {
        episode
            .compactMap { ApiPath(pathString: $0) }
    }
}
