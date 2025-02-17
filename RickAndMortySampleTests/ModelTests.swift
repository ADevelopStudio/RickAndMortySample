//
//  ModelTests.swift
//  RickAndMortySampleTests
//
//  Created by Dmitrii Zverev on 17/2/2025.
//

import Testing
import Foundation
@testable import RickAndMortySample

struct ModelTests {

    @Test func testCharacter() async throws {
        var character = RMCharacter.example
        #expect(character.isDead)
        character.status = .alive
        #expect(!character.isDead)
        #expect(character.episodes.count == 2)
        #expect(character.episodes.first == .episode(27))
        #expect(character.episodes.last == .episode(28))
        #expect(character.origin.apiPath == .location(64))
        #expect(character.location.apiPath == .location(20))
        #expect(URL(string: character.image) != nil )
    }

    @Test func testLocation() async throws {
        let location = RMLocation.example
        #expect(location.name == "Earth (C-137)")
        #expect(location.type == "Planet")
        #expect(location.dimension == "Dimension C-137")
        #expect(location.randomImageName == "planet_1")
        #expect(location.inhabitants.count == 27)
        #expect(location.inhabitants.first == .character(38))
        #expect(location.inhabitants.last == .character(394))
    }

    @Test func testEpisode() async throws {
        var episode = RMEpisode.example
        #expect(episode.name == "Pilot")
        #expect(episode.airDate == "December 2, 2013")
        #expect(episode.episode == "S01E01")
        #expect(episode.participants.count == 19)
        #expect(episode.participants.first == .character(1))
        #expect(episode.participants.last == .character(435))
    }

}
