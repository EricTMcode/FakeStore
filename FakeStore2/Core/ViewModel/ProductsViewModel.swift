//
//  ProductsViewModel.swift
//  FakeStore2
//
//  Created by Eric on 01/01/2026.
//

import Foundation

@Observable
class ProductsViewModel {
    var products = [Product]()
    var isLoading = false
    var error: Error?

    private let service: ProductServiceProtocol

    init(service: ProductServiceProtocol = ProductService()) {
        self.service = service
    }

    func fetchProducts() async {
        isLoading = true

        defer { isLoading = false }
        
        do {
            self.products = try await service.fetchProducts()
        } catch {
            self.error = error
        }
    }
}
