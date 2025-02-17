//
//  ApiPath.swift
//  RickAndMortySample
//
//  Created by Dmitrii Zverev on 13/2/2025.
//

import Foundation

enum ApiPath {
    case characters
    case character(Int)
    case locations
    case location(Int)
    case episodes
    case episode(Int)

    init?(pathString: String?) {
        guard let pathString, let url = URL(string: pathString) else {
            return nil
        }

        // Example: "https://rickandmortyapi.com/api/episode/27"
        // url.pathComponents are: ["/", "api", "episode", "27"]
        let components = url.pathComponents

        // We expect at least: ["/", "api", "<endpoint>"]
        // so we need to check we have enough path parts
        guard components.count >= 3 else { return nil }

        // The third component should be an endpoint: "character", "location", "episode" etc.
        // If there's a next component that can be an Int, parse it as, for example, .location(id).
        var number: Int? {
            if components.count >= 4, let num = Int(components[3]) {
                return num
            }
            return nil
        }

        switch components[2].lowercased() {
        case "character":
            if let number {
                self = .character(number)
            } else {
                self = .characters
            }
        case "location":
            if let number {
                self = .location(number)
            } else {
                self = .locations
            }
        case "episode":
            if let number {
                self = .episode(number)
            } else {
                self = .episodes
            }
        default: return nil
        }
    }
}

extension ApiPath: Hashable, Identifiable {
    var id: String { String(describing: self) }

    func hash(into hasher: inout Hasher) {
        hasher.combine("ApiPath\(id)")
    }

    static func == (lhs: ApiPath, rhs: ApiPath) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: APO Connections
extension ApiPath {
    static let baseUrl = URL(string: "https://rickandmortyapi.com/api")!

    private var path: String {
        switch self {
        case .characters: return "/character"
        case .locations: return "/location"
        case .episodes: return "/episode"
        case .episode(let num): return "/episode/\(num)"
        case .location(let num): return "/location/\(num)"
        case .character(let num): return "/character/\(num)"
        }
    }

    var name: String {
        switch self {
        case .characters: return "Characters"
        case .locations: return "Locations"
        case .episodes: return "Episodes"
        case .episode(let num): return "Episode \(num)"
        case .location(let num): return "Location \(num)"
        case .character(let num): return "Character \(num)"
        }
    }

    var request: URLRequest {
        URLRequest(url: ApiPath.baseUrl.appending(path: path), cachePolicy: .returnCacheDataElseLoad)
    }
}
