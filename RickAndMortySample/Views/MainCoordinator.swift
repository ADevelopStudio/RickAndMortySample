//
//  MainCoordinator.swift
//  RickAndMortySample
//
//  Created by Dmitrii Zverev on 15/2/2025.
//

import SwiftUI

@MainActor
final class MainCoordinator: ObservableObject {
    enum Tabs: CaseIterable {
        case characters
        case episodes
        case locations
        case experimental
    }

    @Published var selectedTab: Tabs = .characters
    @Published var deepLink: ApiPath?
}

extension MainCoordinator.Tabs {
    static var remoteContentTabs: [MainCoordinator.Tabs] {
        self.allCases
            .filter { $0.remoteContentPath != nil }
    }

    var title: String {
        switch self {
        case .characters: return "Characters"
        case .locations: return "Locations"
        case .episodes: return "Episodes"
        case .experimental: return "Extra"
        }
    }

    var icon: String {
        switch self {
        case .characters: return "person.3.sequence"
        case .locations: return "globe"
        case .episodes: return "film.stack"
        case .experimental: return "flame"
        }
    }

    var remoteContentPath: ApiPath? {
        switch self {
        case .characters: return .characters
        case .locations: return .locations
        case .episodes: return .episodes
        default: return nil
        }
    }
}
