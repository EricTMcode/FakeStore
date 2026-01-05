//
//  MockProductService.swift
//  FakeStore2
//
//  Created by Eric on 04/01/2026.
//

import Foundation

struct MockProductService: ProductServiceProtocol {
    var mockProducts = Product.mockProducts
    var errorToThrow: Error?

    func refreshProducts() async throws -> [Product] {
        if let errorToThrow { throw errorToThrow }
        return mockProducts
    }
    
    func fetchProducts() async throws -> [Product] {
        if let errorToThrow { throw errorToThrow }
        return mockProducts
    }
}
