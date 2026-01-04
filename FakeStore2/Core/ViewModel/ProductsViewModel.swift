//
//  ProductsViewModel.swift
//  FakeStore2
//
//  Created by Eric on 01/01/2026.
//

import Foundation

@Observable
class ProductsViewModel {
    var loadingState: ContentLoadingState<Product> = .loading

    private let service: ProductServiceProtocol

    init(service: ProductServiceProtocol = ProductService()) {
        self.service = service
    }

    func fetchProducts() async {
        do {
            let products = try await service.fetchProducts()
            self.loadingState = products.isEmpty ? .empty : .completed(data: products)
        } catch {
            self.loadingState = .error(error: error)
        }
    }

    func refreshProducts() async {
        do {
            let products = try await service.refreshProducts()
            self.loadingState = products.isEmpty ? .empty : .completed(data: products)
        } catch {
            self.loadingState = .error(error: error)
        }
    }
}
