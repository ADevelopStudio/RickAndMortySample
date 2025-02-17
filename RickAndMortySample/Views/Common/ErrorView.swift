//
//  ErrorView.swift
//  RickAndMortySample
//
//  Created by Dmitrii Zverev on 14/2/2025.
//

import SwiftUI

struct ErrorView: View {
    var error: Error

    var body: some View {
        VStack {
            Image(systemName: "icloud.slash")
                .imageScale(.large)
            Text(error.localizedDescription)
        }
        .padding()
    }
}

#Preview {
    ErrorView(error: ApiError.decodingFailed)
}
