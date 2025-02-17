//
//  LazyImageView.swift
//  RickAndMortySample
//
//  Created by Dmitrii Zverev on 13/2/2025.
//

import SwiftUI

struct LazyImageView: View {
    @StateObject private var viewModel = LazyImageViewModel()
    var imageURL: String?
    var isResizable = true

    var body: some View {
        VStack {
            switch viewModel.imageState {
            case .loading:
                ProgressView()
            case .loaded(let image):
                if isResizable {
                    image
                        .resizable()
                } else {
                    image
                }
            case .error:
                Button {
                    Task { await viewModel.reloadImage(from: imageURL) }
                } label: {
                    VStack {
                        Image(systemName: "xmark.icloud")
                            .imageScale(.medium)
                        Text("Retry")
                            .font(.caption2)
                    }
                    .tint(.red)
                }
            }
        }
        .animation(.easeInOut, value: viewModel.imageState.index)
        .task {
            await viewModel.loadImage(from: imageURL)
        }
    }
}

#Preview {
    LazyImageView()
}
