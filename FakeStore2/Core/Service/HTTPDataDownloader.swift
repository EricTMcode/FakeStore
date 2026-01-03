//
//  HTTPDataDownloader.swift
//  FakeStore2
//
//  Created by Eric on 02/01/2026.
//

import Foundation

protocol HTTPDataDownloaderProtocol {
    func fetchData<T: Codable>(as type: T.Type) async throws -> [T]
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
    private let cache: CacheManager?
    private let endpoint: FakeStoreAPIEndpoint
    private var lastFetchedTime: Date?
    private let refreshInterval: TimeInterval = 60 * 10 // 10 minutes

    init(endpoint: FakeStoreAPIEndpoint, cache: CacheManager? = nil) {
        self.endpoint = endpoint
        self.cache = cache
    }

    func fetchData<T: Codable>(as type: T.Type) async throws -> [T] {
        if !needsRefresh, let cache {
            print("DEBUG: Got data from cache...")
            return try cache.getData(as: type)
        }

        print("DEBUG: Getting data from API...")
        let url = try buildURL()
        let (data, response) = try await URLSession.shared.data(from: url)
        try validataResponse(response)

        let result = try JSONDecoder().decode([T].self, from: data)
        return result
    }

    private func saveLastFetchedTime() {
        UserDefaults.standard.set(Date(), forKey: "lastFetchedTime")
    }

    private mutating func getLastFetchedTime() {
        self.lastFetchedTime = UserDefaults.standard.value(forKey: "lastFetchedTime") as? Date
    }

    private var needsRefresh: Bool {
        guard let lastFetchedTime else { return true }
        print("DEBUG: Last fetched time \(lastFetchedTime)")
        print("DEBUG: Time since \(Date().timeIntervalSince(lastFetchedTime))")
        return Date().timeIntervalSince(lastFetchedTime) >= refreshInterval
    }

    private func buildURL() throws -> URL {
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
