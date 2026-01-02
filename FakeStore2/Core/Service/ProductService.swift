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

    func fetchProducts() async throws -> [Product] {
        guard let url = URL(string: URLString) else {
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        try validataResponse(response)
        return try JSONDecoder().decode([Product].self, from: data)
    }

    private func validataResponse(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        guard httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
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
