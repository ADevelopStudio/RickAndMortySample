//
//  ContentView.swift
//  RickAndMortySample
//
//  Created by Dmitrii Zverev on 13/2/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var coordinator = MainCoordinator()
    @StateObject var notificationObserver = NotificationObserver.shared

    var body: some View {
        TabView(selection: $coordinator.selectedTab) {
            ForEach(MainCoordinator.Tabs.remoteContentTabs, id: \.self) { element in
                if let apiPath = element.remoteContentPath {
                    NavigationStack {
                        RemoteContentView(apiPath: apiPath)
                            .addNavigationDestinations()
                    }
                    .tabItem {
                        Label(element.title, systemImage: element.icon)
                    }
                    .tag(element)
                }
            }

            // MARK: experimental tab with coordinator

            NavigationStack(path: $coordinator.navigationPath) {
                ExperementalView()
                    .addNavigationDestinations()
                    .navigationDestination(for: Int.self) {
                        NavigationStackDemo(number: $0)
                    }
                    .navigationDestination(for: MainCoordinator.ExperementalTabs.self) {
                        switch $0 {
                        case .red: Color.red
                        case .blue: Color.blue
                        }
                    }
            }
            .environmentObject(coordinator)
            .tabItem {
                Label(MainCoordinator.Tabs.experimental.title, systemImage: MainCoordinator.Tabs.experimental.icon)
            }
            .tag(MainCoordinator.Tabs.experimental)
        }
        .popover(item: $notificationObserver.deepLink) {
            RemoteContentView(apiPath: $0)
                .addNavigationDestinations()
                .wrapToDismissableNavigation()
        }
        .sheet(isPresented: $coordinator.showDemoSheet) {
            DemoSheetView()
        }
        .sheet(item: $coordinator.demoSheetContent) {
            DemoSheetContentView(content: $0)
        }
    }
}

#Preview {
    ContentView()
}
