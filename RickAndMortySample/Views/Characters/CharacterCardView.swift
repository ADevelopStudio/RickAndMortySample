//
//  CharacterCardView.swift
//  RickAndMortySample
//
//  Created by Dmitrii Zverev on 13/2/2025.
//

import SwiftUI

struct CharacterCardView: View {
    var character: RMCharacter

    init(_ character: RMCharacter) {
        self.character = character
    }

    var body: some View {
        GroupBox {
            HStack {
                LazyImageView(imageURL: character.image)
                    .frame(width: 60, height: 60)
                    .clipShape(.rect(cornerRadius: 10))
                    .opacity(character.isDead ? 0.3 : 1)
                    .overlay {
                        if character.isDead {
                            Text("DEAD")
                                .font(.caption2.bold())
                                .padding(.vertical, 4)
                                .frame(maxWidth: .infinity)
                                .background(.red)
                        }
                    }
                VStack(alignment: .leading) {
                    Text(character.name)
                        .font(.title2)
                    Text(character.shortDescription)
                        .font(.caption)
                }
                .multilineTextAlignment(.leading)
                Spacer()
                Image(systemName: "chevron.right")
            }
        }
    }
}

#Preview {
    CharacterCardView(.example)
        .padding()
}
