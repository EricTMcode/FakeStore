//
//  ProductsViewModelTests.swift
//  FaskeStoreTests
//
//  Created by Eric on 05/01/2026.
//

import Testing
@testable import FakeStore2

@MainActor
struct ProductsViewModelTests {

    @Test func testFetchProductsSuccess() async {
        let service = MockProductService()
        let viewModel = ProductsViewModel(service: service)

        await viewModel.fetchProducts()
    }


}
