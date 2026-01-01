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
        List {
            ForEach(viewModel.products) { product in
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
        .task { await viewModel.fetchProducts() }
    }
}

#Preview {
    ProductsView()
}
