//
//  ListRowView.swift
//  RickAndMortySample
//
//  Created by Dmitrii Zverev on 15/2/2025.
//

import SwiftUI

struct ListRowView: View {
    var title: String
    var message: String?

    var body: some View {
        HStack {
            Text(title + ":")
            Spacer()
            if let message, !message.isEmpty {
                Text(message)
                    .bold()
            } else {
                Text("unknown")
                    .bold()
            }
        }
    }
}
