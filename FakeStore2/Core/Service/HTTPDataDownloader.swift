//
//  HTTPDataDownloader.swift
//  FakeStore2
//
//  Created by Eric on 02/01/2026.
//

import Foundation

protocol HTTPDataDownloaderProtocol {
    func fetchData<T: Codable>(as type: T.Type) async throws -> [T]
    func refreshData<T: Codable>(as type: T.Type) async throws -> [T]
}

class HTTPDataDownloader: HTTPDataDownloaderProtocol {
    private let baseURL = "https://fakestoreapi.com"
    private let cache: CacheManager?
    private let endpoint: FakeStoreAPIEndpoint
    private var lastFetchedTime: Date?
    private let refreshInterval: TimeInterval = 60 * 10 // 10 minutes
    private let userDefaultLastFetchedTimeKey: String

    private let urlBuilder: URLBuilder
    private let responseValidator: HTTPResponseValidator

    init(endpoint: FakeStoreAPIEndpoint, cache: CacheManager? = nil) {
        self.endpoint = endpoint
        self.cache = cache
        self.userDefaultLastFetchedTimeKey = endpoint.path

        self.urlBuilder = URLBuilder(baseURL: baseURL, endpoint: endpoint)
        self.responseValidator = HTTPResponseValidator()

        getLastFetchedTime()
    }

    func fetchData<T: Codable>(as type: T.Type) async throws -> [T] {
        if !needsRefresh, let cache {
            print("DEBUG: Got data from cache...")
            return try cache.getData(as: type)
        }

        print("DEBUG: Getting data from API...")

        let url = try urlBuilder.buildURL()
        let (data, response) = try await URLSession.shared.data(from: url)
        try responseValidator.validateResponse(response)

        let result = try JSONDecoder().decode([T].self, from: data)

        if let cache {
            saveLastFetchedTime()
            cache.saveData(result)
        }

        return result
    }

    func refreshData<T: Codable>(as type: T.Type) async throws -> [T] {
        print("DEBUG: Refreshing data...")
        lastFetchedTime = nil
        cache?.invalidate()
        return try await fetchData(as: type)
    }

    private func saveLastFetchedTime() {
        UserDefaults.standard.set(Date(), forKey: userDefaultLastFetchedTimeKey)
    }

    private func getLastFetchedTime() {
        self.lastFetchedTime = UserDefaults.standard.value(forKey: userDefaultLastFetchedTimeKey) as? Date
    }

    private var needsRefresh: Bool {
        guard let lastFetchedTime else { return true }
        print("DEBUG: Last fetched time \(lastFetchedTime)")
        print("DEBUG: Time since \(Date().timeIntervalSince(lastFetchedTime))")
        return Date().timeIntervalSince(lastFetchedTime) >= refreshInterval
    }
}

