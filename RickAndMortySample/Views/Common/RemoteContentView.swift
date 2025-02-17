//
//  ApiResultLoaderView.swift
//  RickAndMortySample
//
//  Created by Dmitrii Zverev on 15/2/2025.
//

import SwiftUI

struct RemoteContentView: View {
    @StateObject private var viewModel: RemoteContentViewModel

    // to show single element as a card
    private var forCards: Bool

    init(apiPath: ApiPath, forCards: Bool = false) {
        self.forCards = forCards
        _viewModel = StateObject(wrappedValue: RemoteContentViewModel(apiPath: apiPath))
    }

    var body: some View {
        VStack {
            switch viewModel.loadingState {
            case .loading(let contentType):
                if let contentType {
                    makeBoby(contentType)
                } else {
                    ProgressView(["Loading", "\(viewModel.apiPath.name.lowercased())..."].joined(separator: " "))
                }
            case .loaded(let contentType):
                makeBoby(contentType)
                    .refreshable {
                        await viewModel.fetchData(forceRefresh: true)
                    }
            case .error(let error):
                if forCards {
                    Button {
                        Task { await viewModel.fetchData(forceRefresh: true) }
                    } label: {
                        Text([error.localizedDescription, "Retry"].joined(separator: "\n"))
                    }
                } else {
                    ErrorView(error: error)
                        .padding(.vertical)
                    Button("Retry") {
                        Task { await viewModel.fetchData(forceRefresh: true) }
                    }
                }
            }
        }
        .animation(.easeInOut, value: viewModel.loadingState.index)
        .task {
            await viewModel.fetchData()
        }
    }

    @ViewBuilder
    private func makeBoby(_ contentType: ContentType) -> some View {
        switch contentType {
        case .characters(let characters):
            CharactersView(characters: characters)
        case .character(let character):
            if forCards {
                NavigationLink(value: character) {
                    CharacterCardView(character)
                }
            } else {
                CharacterDetailsView(character: character)
            }
        case .locations(let locations):
            LocationsView(locations: locations)
        case .location(let location):

            if forCards {
                NavigationLink(value: location) {
                    LocationCardView(location)
                }
            } else {
                LocationDetailsView(location: location)
            }
        case .episodes(let episodes):
            EpisodesView(episodes: episodes)
        case .episode(let episode):
            if forCards {
                NavigationLink(value: episode) {
                    EpisodeCardView(episode)
                }
            } else {
                EpisodeDetailView(episode: episode)
            }
        }
    }

}

#Preview {
    NavigationStack {
        RemoteContentView(apiPath: .episodes)
    }
}
