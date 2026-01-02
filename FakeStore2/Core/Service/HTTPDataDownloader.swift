//
//  HTTPDataDownloader.swift
//  FakeStore2
//
//  Created by Eric on 02/01/2026.
//

import Foundation

protocol HTTPDataDownloaderProtocol {
    func fetchData<T: Codable>(as type: T.Type, from endpoint: FakeStoreAPIEndpoint) async throws -> [T]
}

enum FakeStoreAPIEndpoint {
    case products
    case users

    var path: String {
        switch self {
        case .products:
            return "/products"
        case .users:
            return "/users"
        }
    }
}

struct HTTPDataDownloader: HTTPDataDownloaderProtocol {
    private let baseURL = "https://fakestoreapi.com"

    func fetchData<T: Decodable>(as type: T.Type, from endpoint: FakeStoreAPIEndpoint) async throws -> [T] {
        let url = try buildURL(endpoint: endpoint)
        let (data, response) = try await URLSession.shared.data(from: url)
        try validataResponse(response)

        let result = try JSONDecoder().decode([T].self, from: data)
        return result
    }

    private func buildURL(endpoint: FakeStoreAPIEndpoint) throws -> URL {
        guard var components = URLComponents(string: baseURL) else { throw APIError.invalidURL }
        components.path = endpoint.path

        guard let url = components.url else { throw APIError.invalidURL }

        return url

    }

    private func validataResponse(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }

        guard httpResponse.statusCode == 200 else {
            throw APIError.invalidResponse
        }
    }
}
