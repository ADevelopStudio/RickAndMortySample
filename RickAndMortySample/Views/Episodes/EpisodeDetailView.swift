//
//  EpisodeDetailView.swift
//  RickAndMortySample
//
//  Created by Dmitrii Zverev on 16/2/2025.
//

import SwiftUI

struct EpisodeDetailView: View {
    var episode: RMEpisode

    var body: some View {
        ScrollView {
            VStack {
                VStack {
                    Text(episode.name)
                        .font(.largeTitle)
                        .bold()
                        .padding(.vertical)
                    HStack {
                        Text(episode.episode)
                            .font(.callout)
                        Spacer()
                        Text(episode.airDate)
                            .font(.callout)
                    }
                }
                .padding(.bottom)

                HStack {
                    Text("Participants:".uppercased())
                        .font(.caption)
                    Text("\(episode.participants.count)")
                        .font(.caption)
                    Spacer()
                }

                LazyVStack {
                    ForEach(episode.participants) {
                        RemoteContentView(apiPath: $0, forCards: true)
                    }
                }
            }
            .tint(.primary)
            .padding()
        }
    }
}

#Preview {
    NavigationStack {
        EpisodeDetailView(episode: .example)
    }
}
