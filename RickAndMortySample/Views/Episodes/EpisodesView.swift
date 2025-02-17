//
//  EpisodesView.swift
//  RickAndMortySample
//
//  Created by Dmitrii Zverev on 16/2/2025.
//

import SwiftUI

struct EpisodesView: View {
    var episodes: [RMEpisode]

    var body: some View {
        if episodes.isEmpty {
            Text("Episodes are empty")
        } else {
            ScrollView {
                LazyVStack {
                    ForEach(episodes) { episode in
                        NavigationLink(value: episode) {
                            EpisodeCardView(episode)
                                .padding(.horizontal)
                                .transition(.opacity.combined(with: .scale))
                        }
                    }
                }
            }
            .navigationTitle("Episodes")
            .tint(.primary)
        }
    }
}

#Preview {
    NavigationStack {
        EpisodesView(episodes: [.example])
    }
}
