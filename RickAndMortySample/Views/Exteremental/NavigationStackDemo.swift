//
//  NavigationStackDemo.swift
//  RickAndMortySample
//
//  Created by Dmitrii Zverev on 17/2/2025.
//

import SwiftUI

struct NavigationStackDemo: View {
    @EnvironmentObject var coordinator: MainCoordinator

    var number: Int

    var body: some View {
        VStack {
            Text("Demonstration of NavigationStack work")

            List {

                Section("using NavigationLink") {
                    NavigationLink(value: number + 1) {
                        Text("Go to \(number + 1) with NavigationLink")
                    }
                }

                Section("using coordinator") {
                    Button("Go to \(number + 1) with coordinator") {
                        coordinator.open(num: number + 1)
                    }

                    Button("Back to second page") {
                        coordinator.backToSecond()
                    }

                    Button("Open RED screen") {
                        coordinator.open(tab: .red)
                    }

                    Button("Open BLUE screen") {
                        coordinator.open(tab: .blue)
                    }

                    Button("Go back twice") {
                        coordinator.backTo(2)
                    }

                    Button("Push To Character 2") {
                        coordinator.pushToCharacter(2)
                    }

                    Button("Demo sheet") {
                        coordinator.showSheet()
                    }

                    Button("Demo sheet with content") {
                        // can be used to present alerts from everywhere
                        let content = DemoSheetContent(fake: true)
                        coordinator.showSheet(with: content)
                    }
                }

                Section("Deeplinks") {
                    Button("Character 3") {
                        NotificationObserver.shared.deepLink = .character(3)
                    }
                    Button("Episode 10") {
                        NotificationObserver.shared.deepLink = .episode(10)
                    }

                    Button("All planets") {
                        NotificationObserver.shared.deepLink = .locations
                    }
                }
            }

        }
        .tint(.primary)
        .navigationTitle("Number \(number)")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("To Root") {
                    coordinator.backToRoot()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        NavigationStackDemo(number: 0)
            .environmentObject(MainCoordinator())
    }
}
