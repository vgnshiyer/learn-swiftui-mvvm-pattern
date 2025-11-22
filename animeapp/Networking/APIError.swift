//
//  APIError.swift
//  animeapp
//
//  Created by Vignesh Iyer on 11/22/25.
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
            case .decodingError(let error): return "Failed to decode: \(error)"
            case .networkError(let error): return "A network error occurred: \(error)"
        }
    }
}
