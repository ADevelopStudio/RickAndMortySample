//
//  EpisodeCardView.swift
//  RickAndMortySample
//
//  Created by Dmitrii Zverev on 16/2/2025.
//

import SwiftUI

struct EpisodeCardView: View {
    var episode: RMEpisode

    init(_ episode: RMEpisode) {
        self.episode = episode
    }

    var body: some View {
        GroupBox {
            HStack {
                VStack(alignment: .leading) {
                    Text(episode.episode)
                        .font(.caption)
                    Text(episode.name)
                        .font(.title2)
                        .bold()
                    Text(episode.airDate)
                        .font(.caption)
                    Text("Characters: \(episode.participants.count)")
                        .font(.caption)
                }
                .multilineTextAlignment(.leading)
                Spacer()
                Image(systemName: "chevron.right")
            }
        }
    }
}

#Preview {
    EpisodeCardView(.example)
}
