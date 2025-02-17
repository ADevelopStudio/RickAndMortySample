//
//  LazyImageViewModel.swift
//  RickAndMortySample
//
//  Created by Dmitrii Zverev on 13/2/2025.
//

import SwiftUI

@MainActor
final class LazyImageViewModel: ObservableObject {

    @Published private(set) var imageState: LoadingState<Image> = .loading()
    private var alreadyStartedLoading = false
    private var loadingCompleted = false

    private(set) var connectionManager: ConnectionManager

    init(connectionManager: ConnectionManager = ConnectionManagerImpl.shared) {
        self.connectionManager = connectionManager
    }

    func loadImage(from urlString: String?) async {
        defer { loadingCompleted = true }
        if alreadyStartedLoading { return }
        alreadyStartedLoading = true
        self.imageState = .loading()

        guard let urlString, let url = URL(string: urlString) else {
            self.imageState = .error(ApiError.invalidURL)
            return
        }
        let request = URLRequest(url: url)
        if let cachedResponse = URLCache.shared.cachedResponse(for: request),
           let cachedImage = UIImage(data: cachedResponse.data) {
            imageState = .loaded(Image(uiImage: cachedImage))
            return
        }
        do {
            let (data, response) = try await connectionManager.loadData(from: request)
            let cachedData = CachedURLResponse(response: response, data: data)
            URLCache.shared.storeCachedResponse(cachedData, for: request)
            if let image = UIImage(data: data) {
                imageState = .loaded(Image(uiImage: image))
            } else {
                imageState = .error(ApiError.invalidResponse)
            }
        } catch {
            imageState = .error(error)
        }
    }

    func reloadImage(from urlString: String?) async {
        if !loadingCompleted { return }
        loadingCompleted = false
        alreadyStartedLoading = false
        await self.loadImage(from: urlString)
    }
}
