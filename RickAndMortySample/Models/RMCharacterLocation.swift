//
//  RMCharacterLocation.swift
//  RickAndMortySample
//
//  Created by Dmitrii Zverev on 13/2/2025.
//

import Foundation

struct RMCharacterLocation: Codable {
    var name: String
    var url: String
}

extension RMCharacterLocation {
    var apiPath: ApiPath? {
        ApiPath(pathString: url)
    }

    var id: Int? {
        switch apiPath {
        case .location(let int): return int
        default: return nil
        }
    }
}
