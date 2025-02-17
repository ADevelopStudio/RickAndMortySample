//
//  DemoSheetView.swift
//  RickAndMortySample
//
//  Created by Dmitrii Zverev on 17/2/2025.
//

import SwiftUI

struct DemoSheetView: View {
    var body: some View {
        VStack {
            Text("Demo sheet")
                .font(.largeTitle)
            Text("Swipe Up to scale")
        }
        .presentationDetents([.medium, .large])
    }
}

struct DemoSheetContent: Equatable, Identifiable {
    var title: String
    var text: String
    var id: UUID

    init(title: String, text: String) {
        id = UUID()
        self.title = title
        self.text = text
    }

    // swiftlint:disable line_length
    // swiftlint:disable:next superfluous_disable_command
    init(fake: Bool) {
        id = UUID()
        self.title = "I'm a title"
        self.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua"
    }
    // swiftlint:enable line_length
}

struct DemoSheetContentView: View {
    @Environment(\.dismiss) var dismiss
    var content: DemoSheetContent

    var body: some View {
        VStack(spacing: 20) {
            Text(content.title)
                .font(.largeTitle)
                .bold()
                .padding(.top, 20)
            Text(content.text)
            Spacer()
            Button("Dismiss") {
                dismiss()
            }
        }
        .multilineTextAlignment(.center)
        .padding()
        .presentationDetents([.medium, .large])
    }
}

#Preview {
    DemoSheetContentView(content: .init(fake: true))
}
