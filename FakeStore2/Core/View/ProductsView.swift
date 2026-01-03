//
//  ProductsView.swift
//  FakeStore2
//
//  Created by Eric on 01/01/2026.
//

import SwiftUI

struct ProductsView: View {
    @State private var viewModel = ProductsViewModel()

    var body: some View {
        VStack {
            switch viewModel.loadingState {
            case .loading:
                ProgressView()
            case .empty:
                ContentUnavailableView("No Products", systemImage: "cart.slash")
            case .error(let error):
                Text(error.localizedDescription)
            case .completed(let products):
                List {
                    ForEach(products) { product in
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
            }
        }
        .task { await viewModel.fetchProducts() }
    }
}

#Preview {
    ProductsView()
}
