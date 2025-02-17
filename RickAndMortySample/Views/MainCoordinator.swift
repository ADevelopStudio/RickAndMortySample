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

// MARK: for demo working with Navigation Stack iOS16+ for programmatic/manual navigation on Experemental tab
    enum ExperementalTabs: CaseIterable {
        case red
        case blue
    }

    @Published var navigationPath = NavigationPath()
    @Published var showDemoSheet = false
    @Published var demoSheetContent: DemoSheetContent?

    func open(tab: ExperementalTabs) {
        navigationPath.append(tab)
    }

    func backToRoot() {
        navigationPath = NavigationPath()
    }

    func showSheet() {
        showDemoSheet = true
    }

    func showSheet(with content: DemoSheetContent) {
        demoSheetContent = content
    }

    func backTo(_ steps: Int) {
        navigationPath.removeLast(steps)
    }

    func backToSecond() {
        navigationPath.removeLast(navigationPath.count - 1)
    }

    func open(num: Int) {
        navigationPath.append(num)
    }

    func pushToCharacter(_ int: Int) {
        navigationPath.append(ApiPath.character(int))
    }
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
