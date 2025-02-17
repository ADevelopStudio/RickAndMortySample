//
//  LocationDetailsView.swift
//  RickAndMortySample
//
//  Created by Dmitrii Zverev on 15/2/2025.
//

import SwiftUI

struct LocationDetailsView: View {
    var location: RMLocation

    var body: some View {
        ScrollView {
            VStack {
                VStack {
                    Text(location.name)
                        .font(.title)
                        .bold()
                        .multilineTextAlignment(.center)
                    Image(location.randomImageName)
                        .resizable()
                        .frame(width: 200, height: 200)
                    ListRowView(title: "Type", message: location.type)
                    ListRowView(title: "Dimension", message: location.dimension)
                }
                .padding(.bottom)

                HStack {
                    Text("Characters:".uppercased())
                        .font(.caption)
                    Text("\(location.inhabitants.count)")
                        .font(.caption)
                    Spacer()
                }
                LazyVStack {
                    ForEach(location.inhabitants) {
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
        LocationDetailsView(location: .example)
    }
}
