//
//  LocationsView.swift
//  RickAndMortySample
//
//  Created by Dmitrii Zverev on 15/2/2025.
//

import SwiftUI

struct LocationsView: View {
    var locations: [RMLocation]

    var body: some View {
        if locations.isEmpty {
            Text("Locations are empty")
        } else {
            ScrollView {
                LazyVStack {
                    ForEach(locations) { location in
                        NavigationLink(value: location) {
                            LocationCardView(location)
                                .padding(.horizontal)
                                .transition(.opacity.combined(with: .scale))
                        }
                    }
                }
            }
            .navigationTitle("Locations")
            .tint(.primary)
        }
    }
}

#Preview {
    NavigationStack {
        LocationsView(locations: [.example])
    }
}
