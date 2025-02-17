//
//  ApiError.swift
//  RickAndMortySample
//
//  Created by Dmitrii Zverev on 17/2/2025.
//

import Foundation

enum ApiError: Error {
    case invalidResponse
    case decodingFailed
    case invalidURL
}

extension ApiError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidResponse: return "Invalid response"
        case .decodingFailed: return "Decoding failed"
        case .invalidURL: return "Invalid URL"
        }
    }
}
