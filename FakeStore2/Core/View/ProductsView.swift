//
//  ProductsView.swift
//  FakeStore2
//
//  Created by Eric on 01/01/2026.
//

import SwiftUI

struct ProductsView: View {
    @State private var viewModel = ProductsViewModel()
    @State private var searchText = ""

    var body: some View {
        NavigationStack {
            VStack {
                switch viewModel.loadingState {
                case .loading:
                    ProgressView()
                case .empty:
                    ContentUnavailableView("No Products", systemImage: "cart.slash")
                case .error(let error):
                    Text(error.localizedDescription)
                case .completed:
                    List {
                        ForEach(filteredProducts) { product in
                            HStack(spacing: 16) {
                                AsyncImage(url: URL(string: product.image))
                                    .scaledToFill()
                                    .frame(width: 80, height: 80)
                                    .clipShape(.rect(cornerRadius: 10))

                                VStack(alignment: .leading) {
                                    Text(product.title)

                                    Text(product.description)
                                        .foregroundStyle(.gray)
                                        .lineLimit(2)
                                }
                            }
                            .font(.subheadline)
                        }
                    }
                    .searchable(text: $searchText, prompt: "Search products...")
                }
            }
            .navigationTitle("Products")
            .refreshable { await viewModel.refreshProducts() }
            .task { await viewModel.fetchProducts() }
        }
    }
}

private extension ProductsView {
    var filteredProducts: [Product] {
        if searchText.isEmpty {
            return viewModel.products
        } else {
            return viewModel.products.filter { product in
                product.title.localizedCaseInsensitiveContains(searchText) ||
                product.description .localizedCaseInsensitiveContains(searchText)
            }
        }
    }
}

#Preview {
    ProductsView()
}
