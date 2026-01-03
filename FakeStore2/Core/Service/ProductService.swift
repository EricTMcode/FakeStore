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
    private let downloader: HTTPDataDownloaderProtocol

    init(downloader: HTTPDataDownloaderProtocol = HTTPDataDownloader(endpoint: .products, cache: CacheManager(filename: "products.json"))) {
        self.downloader = downloader
        getLastFetchedTime()
    }

    func fetchProducts() async throws -> [Product] {
        return try await downloader.fetchData(as: Product.self)
    }
}

struct MockProductService: ProductServiceProtocol {
    func fetchProducts() async throws -> [Product] {
        return Product.mockProducts
    }
}


// When not using a protocol we use conrecte type, it's not f lexible and not very testable.
// Using a protocol give us the power to use Abstract type (abstraction) we can now use Mock to test.
