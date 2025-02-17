//
//  RickAndMortySampleApp.swift
//  RickAndMortySample
//
//  Created by Dmitrii Zverev on 13/2/2025.
//

import SwiftUI

@main
struct RickAndMortySampleApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @AppStorage("appearance") var appearance: AppearanceOption = .system

    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(appearance.colorScheme)
                .accentColor(appearance.accentColor)
        }
    }
}
