//
//  LocationCardView.swift
//  RickAndMortySample
//
//  Created by Dmitrii Zverev on 15/2/2025.
//

import SwiftUI

struct LocationCardView: View {
    var location: RMLocation

    init(_ location: RMLocation) {
        self.location = location
    }

    var body: some View {
        GroupBox {
            HStack(spacing: 10) {
                Image(location.randomImageName)
                    .resizable()
                    .frame(width: 60, height: 60)
                VStack(alignment: .leading) {
                    Text(location.name)
                        .font(.title2)
                        .bold()
                    Text(location.type)
                    if !location.dimension.isEmpty {
                        Text(location.dimension)
                            .font(.caption2)
                    }
                }
                .multilineTextAlignment(.leading)
                Spacer()
                Image(systemName: "chevron.right")
            }
        }
    }
}

#Preview {
    LocationCardView(.example)
        .padding()
}
