//
//  MockProductService.swift
//  FakeStore2
//
//  Created by Eric on 04/01/2026.
//

import Foundation

struct MockProductService: ProductServiceProtocol {
    func refreshProducts() async throws -> [Product] {
        return Product.mockProducts
    }
    
    func fetchProducts() async throws -> [Product] {
        return Product.mockProducts
    }
}
