//
//  ProductsViewModel.swift
//  FakeStore2
//
//  Created by Eric on 01/01/2026.
//

import Foundation

@Observable
class ProductsViewModel {
    var loadingState: ContentLoadingState = .loading
    var products = [Product]()

    private let service: ProductServiceProtocol

    init(service: ProductServiceProtocol = ProductService()) {
        self.service = service
    }

    func fetchProducts() async {
        do {
            self.products = try await service.fetchProducts()
            let products = try await service.fetchProducts()
            self.loadingState = products.isEmpty ? .empty : .completed
        } catch {
            self.loadingState = .error(error: error)
        }
    }

    func refreshProducts() async {
        do {
            self.products = try await service.refreshProducts()
            self.loadingState = products.isEmpty ? .empty : .completed
        } catch {
            self.loadingState = .error(error: error)
        }
    }
}
