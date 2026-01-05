//
//  MockProductService.swift
//  FakeStore2
//
//  Created by Eric on 04/01/2026.
//

import Foundation

struct MockProductService: ProductServiceProtocol {
    var mockProducts = Product.mockProducts

    func refreshProducts() async throws -> [Product] {
        return mockProducts
    }
    
    func fetchProducts() async throws -> [Product] {
        return mockProducts
    }
}
