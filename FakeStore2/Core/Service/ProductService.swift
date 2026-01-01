//
//  ProductService.swift
//  FakeStore2
//
//  Created by Eric on 01/01/2026.
//

import Foundation

struct ProductService {
    func fetchProducts() async throws -> [Product] {
        return Product.mockProducts
    }
}
