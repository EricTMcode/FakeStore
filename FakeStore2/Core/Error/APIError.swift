//
//  APIError.swift
//  FakeStore2
//
//  Created by Eric on 02/01/2026.
//

import Foundation

enum APIError: Error {
    case invalidData
    case invalidResponse
    case invalidURL
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidData:
            return "Invalid data returned from the API."
        case .invalidResponse:
            return "Invalid HTTP response from the API"
        case .invalidURL:
            return "Invalid URL provided to the API"
        }
    }
}
