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

        #expect(viewModel.products == Product.mockProducts)
        #expect(viewModel.loadingState == .completed)
    }


    @Test func testFetchProductsEmptyState() async {
        var service = MockProductService()
        service.mockProducts = []
        let viewModel = ProductsViewModel(service: service)

        await viewModel.fetchProducts()

        #expect(viewModel.products.isEmpty)
        #expect(viewModel.loadingState == .empty)
    }

    @Test func testFetchProductsFailure() async {
        var service = MockProductService()
        let error = APIError.invalidData
        service.errorToThrow = error
        let viewModel = ProductsViewModel(service: service)

        await viewModel.fetchProducts()

        #expect(viewModel.products.isEmpty)
        #expect(viewModel.loadingState == . error(error: error))
    }

    @Test func testRefreshProductsSuccess() async {
        let service = MockProductService()
        let viewModel = ProductsViewModel(service: service)

        await viewModel.fetchProducts()

        #expect(viewModel.products.count == Product.mockProducts.count)
        #expect(viewModel.loadingState == .completed)
    }

    @Test func testRefreshProductsFailure() async {
        var service = MockProductService()
        let error = APIError.invalidURL
        service.errorToThrow = error

        let viewModel = ProductsViewModel(service: service)

        await viewModel.refreshProducts()

        #expect(viewModel.products.isEmpty)
        #expect(viewModel.loadingState == .error(error: error))
    }

}
