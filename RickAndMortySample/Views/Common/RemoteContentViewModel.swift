//
//  ApiContentLoaderViewModel.swift
//  RickAndMortySample
//
//  Created by Dmitrii Zverev on 15/2/2025.
//

import Foundation

@MainActor
final class RemoteContentViewModel: ObservableObject {
    @Published var loadingState: LoadingState<ContentType> = .loading()
    private var connectionManager: ConnectionManager
    private var isLoaded: Bool = false

    private(set) var apiPath: ApiPath

    init(connectionManager: ConnectionManager = ConnectionManagerImpl.shared, apiPath: ApiPath) {
        self.connectionManager = connectionManager
        self.apiPath = apiPath
    }

    func fetchData(forceRefresh: Bool = false) async {
        if isLoaded, !forceRefresh { return }
        isLoaded = true
        loadingState = .loading(loadingState.currentValue)

        do {
            switch apiPath {
            case .characters:
                let result: RMCharacterResponse = try await connectionManager.fetch(apiPath)
                loadingState = .loaded(.characters(result.results))
            case .character:
                let result: RMCharacter = try await connectionManager.fetch(apiPath)
                loadingState = .loaded(.character(result))
            case .locations:
                let result: RMLocationResponse = try await connectionManager.fetch(apiPath)
                loadingState = .loaded(.locations(result.results))
            case .location:
                let result: RMLocation = try await connectionManager.fetch(apiPath)
                loadingState = .loaded(.location(result))
            case .episodes:
                let result: RMEpisodeResponse = try await connectionManager.fetch(apiPath)
                loadingState = .loaded(.episodes(result.results))
            case .episode:
                let result: RMEpisode = try await connectionManager.fetch(apiPath)
                loadingState = .loaded(.episode(result))
            }
        } catch {
            loadingState = .error(error)
        }
    }
}
