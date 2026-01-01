//
//  FakeStoreTabView.swift
//  FakeStore2
//
//  Created by Eric on 01/01/2026.
//

import SwiftUI

struct FakeStoreTabView: View {
    var body: some View {
        TabView {
            Tab("Products", systemImage: "cart") {
                ProductsView()
            }

            Tab("Users", systemImage: "person") {
                UsersView()
            }
        }
    }
}

#Preview {
    FakeStoreTabView()
}
