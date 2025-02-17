//
//  CharacterDetailsView.swift
//  RickAndMortySample
//
//  Created by Dmitrii Zverev on 15/2/2025.
//

import SwiftUI

struct CharacterDetailsView: View {
    var character: RMCharacter

    var body: some View {
        VStack {
            LazyImageView(imageURL: character.image)
                .frame(width: 200, height: 200)
                .clipShape(.rect(cornerRadius: 20))
            Text(character.name)
                .font(.title)
                .bold()
            List {
                Section("Info") {
                    ListRowView(title: "Status", message: character.status?.rawValue)
                    ListRowView(title: "Species", message: character.species)
                    ListRowView(title: "Gender", message: character.gender)
                    ListRowView(title: "Type", message: character.type)
                    ListRowView(title: "Created", message: character.created.formatted(.dateTime.day().month().year()))
                }

                Section("Origin") {
                    if let apiPath = character.origin.apiPath {
                        NavigationLink(value: apiPath) {
                            locationView(character.origin)
                        }
                    } else {
                        locationView(character.origin)
                    }
                }

                Section("Location") {
                    if let apiPath = character.location.apiPath {
                        NavigationLink(value: apiPath) {
                            locationView(character.location)
                        }
                    } else {
                        locationView(character.location)
                    }
                }
                Section("Appearance") {
                    DisclosureGroup("^[\(character.episodes.count) episode](inflect: true)") {
                        ForEach(character.episodes) { episode in
                            NavigationLink(value: episode) {
                                Text(episode.name)
                            }
                        }
                    }
                    .tint(.primary)
                }

            }
            .listStyle(.sidebar)
        }
    }

    private func locationView(_ loc: RMCharacterLocation) -> some View {
        Label {
            Text(loc.name)
        } icon: {
            if let id = loc.id {
                Image("planet_\(id % 15)")
                    .resizable()
                    .frame(width: 30, height: 30)
            } else {
                Image(systemName: "globe")
                    .resizable()
                    .frame(width: 30, height: 30)
            }
        }
    }
}

#Preview {
    NavigationStack {
        CharacterDetailsView(character: .example)
    }
}
