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
                Section("Location") {
                    if let apiPath = character.location.apiPath {
                        NavigationLink(value: apiPath) {
                            locationView
                        }
                    } else {
                        locationView
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

    private var locationView: some View {
        Label {
            Text(character.location.name)
        } icon: {
            if let id = character.location.id {
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
