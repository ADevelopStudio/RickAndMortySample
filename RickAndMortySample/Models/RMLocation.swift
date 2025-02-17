//
//  RMLocation.swift
//  RickAndMortySample
//
//  Created by Dmitrii Zverev on 15/2/2025.
//

import Foundation

struct RMLocationResponse: Codable {
    var results: [RMLocation]
}

struct RMLocation: Codable, Identifiable {
    var id: Int
    var name: String
    var type: String
    var dimension: String
    private var residents: [String]
}

extension RMLocation {
    var randomImageName: String {
        "planet_\(id % 15)"
    }

    var inhabitants: [ApiPath] {
        residents
            .compactMap { ApiPath(pathString: $0) }
            .filter {
                switch $0 {
                case .character: return true
                default: return false
                }
            }
    }
}

extension RMLocation: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine("RMLocation\(id)")
    }
    static func == (lhs: RMLocation, rhs: RMLocation) -> Bool {
        lhs.id == rhs.id
    }
}
