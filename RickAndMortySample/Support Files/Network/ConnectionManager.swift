//
//  ConnectionManager.swift
//  RickAndMortySample
//
//  Created by Dmitrii Zverev on 13/2/2025.
//

import Foundation

protocol ConnectionManager {
    func fetch<T: Decodable>(_ path: ApiPath) async throws -> T
    func loadData(from request: URLRequest) async throws -> (Data, URLResponse)
}
