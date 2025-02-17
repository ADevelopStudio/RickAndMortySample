//
//  Mock.swift
//  RickAndMortySample
//
//  Created by Dmitrii Zverev on 16/2/2025.
//

import Foundation

extension RMCharacter {
    static var example: RMCharacter {
        let str = """
         {
           "id": 361,
           "name": "Toxic Rick",
           "status": "Dead",
           "species": "Humanoid",
           "type": "Rick's Toxic Side",
           "gender": "Male",
           "origin": {
             "name": "Alien Spa",
             "url": "https://rickandmortyapi.com/api/location/64"
           },
           "location": {
             "name": "Earth",
             "url": "https://rickandmortyapi.com/api/location/20"
           },
           "image": "https://rickandmortyapi.com/api/character/avatar/361.jpeg",
           "episode": [
             "https://rickandmortyapi.com/api/episode/27",
             "https://rickandmortyapi.com/api/episode/28"
           ],
           "url": "https://rickandmortyapi.com/api/character/361",
           "created": "2018-01-10T18:20:41.703Z"
         }
        """

        let data = str.data(using: .utf8)!
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)

        do {
            let character = try decoder.decode(RMCharacter.self, from: data)
            return character
        } catch {
            fatalError(String(describing: error))
        }
    }
}

extension RMEpisode {
    static var example: RMEpisode {
        let str = """
        {
                    "id": 1,
                    "name": "Pilot",
                    "air_date": "December 2, 2013",
                    "episode": "S01E01",
                    "characters": [
                        "https://rickandmortyapi.com/api/character/1",
                        "https://rickandmortyapi.com/api/character/2",
                        "https://rickandmortyapi.com/api/character/35",
                        "https://rickandmortyapi.com/api/character/38",
                        "https://rickandmortyapi.com/api/character/62",
                        "https://rickandmortyapi.com/api/character/92",
                        "https://rickandmortyapi.com/api/character/127",
                        "https://rickandmortyapi.com/api/character/144",
                        "https://rickandmortyapi.com/api/character/158",
                        "https://rickandmortyapi.com/api/character/175",
                        "https://rickandmortyapi.com/api/character/179",
                        "https://rickandmortyapi.com/api/character/181",
                        "https://rickandmortyapi.com/api/character/239",
                        "https://rickandmortyapi.com/api/character/249",
                        "https://rickandmortyapi.com/api/character/271",
                        "https://rickandmortyapi.com/api/character/338",
                        "https://rickandmortyapi.com/api/character/394",
                        "https://rickandmortyapi.com/api/character/395",
                        "https://rickandmortyapi.com/api/character/435"
                    ],
                    "url": "https://rickandmortyapi.com/api/episode/1",
                    "created": "2017-11-10T12:56:33.798Z"
                }
        """

        let data = str.data(using: .utf8)!
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)

        do {
            let result = try decoder.decode(RMEpisode.self, from: data)
            return result
        } catch {
            fatalError(String(describing: error))
        }
    }
}

extension RMLocation {
    static var example: RMLocation {
        let str = """
        {
            "id": 1,
            "name": "Earth (C-137)",
            "type": "Planet",
            "dimension": "Dimension C-137",
            "residents": [
                "https://rickandmortyapi.com/api/character/38",
                "https://rickandmortyapi.com/api/character/45",
                "https://rickandmortyapi.com/api/character/71",
                "https://rickandmortyapi.com/api/character/82",
                "https://rickandmortyapi.com/api/character/83",
                "https://rickandmortyapi.com/api/character/92",
                "https://rickandmortyapi.com/api/character/112",
                "https://rickandmortyapi.com/api/character/114",
                "https://rickandmortyapi.com/api/character/116",
                "https://rickandmortyapi.com/api/character/117",
                "https://rickandmortyapi.com/api/character/120",
                "https://rickandmortyapi.com/api/character/127",
                "https://rickandmortyapi.com/api/character/155",
                "https://rickandmortyapi.com/api/character/169",
                "https://rickandmortyapi.com/api/character/175",
                "https://rickandmortyapi.com/api/character/179",
                "https://rickandmortyapi.com/api/character/186",
                "https://rickandmortyapi.com/api/character/201",
                "https://rickandmortyapi.com/api/character/216",
                "https://rickandmortyapi.com/api/character/239",
                "https://rickandmortyapi.com/api/character/271",
                "https://rickandmortyapi.com/api/character/302",
                "https://rickandmortyapi.com/api/character/303",
                "https://rickandmortyapi.com/api/character/338",
                "https://rickandmortyapi.com/api/character/343",
                "https://rickandmortyapi.com/api/character/356",
                "https://rickandmortyapi.com/api/character/394"
            ],
            "url": "https://rickandmortyapi.com/api/location/1",
            "created": "2017-11-10T12:42:04.162Z"
        }
"""
        let data = str.data(using: .utf8)!
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)

        do {
            let result = try decoder.decode(RMLocation.self, from: data)
            return result
        } catch {
            fatalError(String(describing: error))
        }

    }
}
