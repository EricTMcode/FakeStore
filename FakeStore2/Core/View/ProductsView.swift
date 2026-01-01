//
//  ProductsView.swift
//  FakeStore2
//
//  Created by Eric on 01/01/2026.
//

import SwiftUI

struct ProductsView: View {
    let products = Product.mockProducts

    var body: some View {
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

#Preview {
    ProductsView()
}
