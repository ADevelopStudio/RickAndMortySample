//
//  ExperementalView.swift
//  RickAndMortySample
//
//  Created by Dmitrii Zverev on 16/2/2025.
//

import SwiftUI

struct ExperementalView: View {
    @EnvironmentObject var coordinator: MainCoordinator
    @AppStorage("appearance") var appearance: AppearanceOption = .system

    var body: some View {
        VStack {
            List {
                Section {
                    DisclosureGroup("Choose tab to open") {
                        ForEach(MainCoordinator.Tabs.remoteContentTabs, id: \.self) { path in
                            Button {
                                coordinator.selectedTab = path
                            } label: {
                                Label(path.title, systemImage: path.icon)
                            }
                        }
                    }
                } header: {
                    Text("Testing EnvironmentObject and openning tabs")
                } footer: {
                    Text("Should open the selected tab")
                }

                Section {
                    NavigationLink(value: 0) {
                        Text("Let's have some fun")
                    }
                } header: {
                    Text("Navigation Stack with coordinator")
                }

                Section {
                    NavigationLink("Push Notifications") {
                        PushNotificationsView()
                    }
                }
                Section {
                    Picker("Appearance", selection: $appearance) {
                        ForEach(AppearanceOption.allCases, id: \.self) {
                            Text($0.name)
                        }
                    }
                }
            }
            Spacer()
            Text("(c) Dmitrii Zverev. Feb 2025")
                .opacity(0.5)
                .font(.footnote)
                .padding(.horizontal)
                .padding(.bottom)
        }
        .tint(.primary)
        .navigationTitle("Experimental")
    }
}

#Preview {
    NavigationStack {
        ExperementalView()
            .environmentObject(MainCoordinator())
    }

}
