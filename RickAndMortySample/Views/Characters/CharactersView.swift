//
//  CharactersView.swift
//  RickAndMortySample
//
//  Created by Dmitrii Zverev on 13/2/2025.
//

import SwiftUI

struct CharactersView: View {
    var characters: [RMCharacter]

    var body: some View {
        if characters.isEmpty {
            Text("Characters are empty")
        } else {
            ScrollView {
                LazyVStack {
                    ForEach(characters) { character in
                        NavigationLink(value: character) {
                            CharacterCardView(character)
                                .padding(.horizontal)
                                .transition(.opacity.combined(with: .scale))
                        }
                    }
                }
            }
            .navigationTitle("Characters")
            .tint(.primary)
        }
    }
}

#Preview {
    NavigationStack {
        CharactersView(characters: [.example])
    }
}
