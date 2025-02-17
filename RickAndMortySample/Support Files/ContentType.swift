//
//  ContentType.swift
//  RickAndMortySample
//
//  Created by Dmitrii Zverev on 15/2/2025.
//

import Foundation

enum ContentType {
    case characters([RMCharacter])
    case character(RMCharacter)
    case locations([RMLocation])
    case location(RMLocation)
    case episodes([RMEpisode])
    case episode(RMEpisode)
}
