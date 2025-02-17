//
//  ViewModifiers.swift
//  RickAndMortySample
//
//  Created by Dmitrii Zverev on 17/2/2025.
//

import SwiftUI

private struct DismissableNavigationModifier: ViewModifier {
    @Environment(\.dismiss) var dismiss

    func body(content: Content) -> some View {
        NavigationStack {
            content
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("", systemImage: "xmark") { dismiss() }
                    }
                }
        }
    }
}

private struct NavigationDestinationsModifier: ViewModifier {

    func body(content: Content) -> some View {
        content
            .navigationDestination(for: ApiPath.self) {
                RemoteContentView(apiPath: $0)
            }
            .navigationDestination(for: RMCharacter.self) {
                CharacterDetailsView(character: $0)
            }
            .navigationDestination(for: RMEpisode.self) {
                EpisodeDetailView(episode: $0)
            }
            .navigationDestination(for: RMLocation.self) {
                LocationDetailsView(location: $0)
            }
    }
}

extension View {
    func wrapToDismissableNavigation() -> some View {
        modifier(DismissableNavigationModifier())
    }

    func addNavigationDestinations() -> some View {
        modifier(NavigationDestinationsModifier())
    }
}
