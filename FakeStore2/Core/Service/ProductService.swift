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

    func fetchProducts() async throws -> [Product] {
        if let cachedProducts = try cache.getProducts() {
            print("DEBUG: Getting products from CACHE")
            return cachedProducts
        }

        print("DEBUG: Getting products from API")
        guard let url = URL(string: URLString) else {
            throw APIError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        try validataResponse(response)

        let products = try JSONDecoder().decode([Product].self, from: data)
        cache.saveProducts(products)
        return products
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

struct MockProductService: ProductServiceProtocol {
    func fetchProducts() async throws -> [Product] {
        return Product.mockProducts
    }
}


// When not using a protocol we use conrecte type, it's not f lexible and not very testable.
// Using a protocol give us the power to use Abstract type (abstraction) we can now use Mock to test.
