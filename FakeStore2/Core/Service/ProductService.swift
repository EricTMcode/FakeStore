//
//  ProductService.swift
//  FakeStore2
//
//  Created by Eric on 01/01/2026.
//

import Foundation

protocol ProductServiceProtocol {
    func fetchProducts() async throws -> [Product]
}

struct ProductService: ProductServiceProtocol {
    private let URLString = "https://fakestoreapi.com/products"
    private let cache = ProductsCache()
    private let refreshInterval: TimeInterval = 60 * 10 // 10 minutes
    private var lastFetchedTime: Date?

    init() {
        getLastFetchedTime()
    }

    func fetchProducts() async throws -> [Product] {
        if !needsRefresh, let cachedProducts = try cache.getProducts() {
            print("DEBUG: Getting products from CACHE")
            return cachedProducts
        }

        print("DEBUG: Getting products from API")
        guard let url = URL(string: URLString) else {
            throw APIError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)
        try validataResponse(response)

        saveLastFetchedTime()

        let products = try JSONDecoder().decode([Product].self, from: data)
        cache.saveProducts(products)

        return products
    }

    private func saveLastFetchedTime() {
        UserDefaults.standard.set(Date(), forKey: "lastFetchedTime")
    }

    private mutating func getLastFetchedTime() {
        self.lastFetchedTime = UserDefaults.standard.value(forKey: "lastFetchedTime") as? Date
    }

    private func validataResponse(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }

        guard httpResponse.statusCode == 200 else {
            throw APIError.invalidResponse
        }
    }

    private var needsRefresh: Bool {
        guard let lastFetchedTime else { return true }
        print("DEBUG: Last fetched time \(lastFetchedTime)")
        print("DEBUG: Time since \(Date().timeIntervalSince(lastFetchedTime))")
        return Date().timeIntervalSince(lastFetchedTime) >= refreshInterval
    }
}

struct MockProductService: ProductServiceProtocol {
    func fetchProducts() async throws -> [Product] {
        return Product.mockProducts
    }
}


// When not using a protocol we use conrecte type, it's not f lexible and not very testable.
// Using a protocol give us the power to use Abstract type (abstraction) we can now use Mock to test.
