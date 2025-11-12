//
//  APIError.swift
//  Ghibli
//
//  Created by Nitin Kumar on 12/11/25.
//

import Foundation

enum APIError: LocalizedError {
    
    case invalidURL
    case invalidResponse
    case decodingError(Error)
    case networkError(Error)
    
    var errorDescription: String? {
        switch self {
            case .invalidURL: return "Invalid URL"
            case .invalidResponse: return "Invalid Response"
            case .decodingError(let error): return "Decoding Error: \(error.localizedDescription)"
            case .networkError(let error): return "Network Error: \(error.localizedDescription)"
        }
    }
}
