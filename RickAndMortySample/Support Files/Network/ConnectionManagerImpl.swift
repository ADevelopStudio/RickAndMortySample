//
//  ConnectionManagerImpl.swift
//  RickAndMortySample
//
//  Created by Dmitrii Zverev on 17/2/2025.
//

import Foundation

struct ConnectionManagerImpl: ConnectionManager {
    static let shared = ConnectionManagerImpl()

    static private var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return dateFormatter
    }

    func fetch<T: Decodable>(_ path: ApiPath) async throws -> T {
        let (data, _)  = try await self.loadData(from: path.request)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .formatted(ConnectionManagerImpl.dateFormatter)
        guard let decoded = try? decoder.decode(T.self, from: data) else {
            Log.error("Failed to decode \(T.self) from \(path.request.url?.relativePath ?? path.name)")
            if let str = String(data: data, encoding: .utf8) { Log.debug(str) }
            throw ApiError.decodingFailed
        }
        return decoded
    }

    func loadData(from request: URLRequest) async throws -> (Data, URLResponse) {
        guard let (data, response)  = try? await URLSession.shared.data(for: request) else {
            Log.error("InvalidResponse for \(request.url?.relativePath ?? "-")")
            throw ApiError.invalidResponse
        }
        return (data, response)
    }
}
