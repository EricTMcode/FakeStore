//
//  UsersView.swift
//  FakeStore2
//
//  Created by Eric on 01/01/2026.
//

import SwiftUI

struct UsersView: View {
    @State private var viewModel = UsersViewModel()

    var body: some View {
        Group {
            switch viewModel.loadingState {
            case .loading:
                ProgressView()
            case .empty:
                ContentUnavailableView("No Users Available", systemImage: "person.slash")
            case .error(let error):
                Text(error.localizedDescription)
            case .completed(let users):
                List {
                    ForEach(users) { user in
                        HStack(spacing: 16) {
                            Text("\(user.id)")

                            VStack(alignment: .leading, spacing: 4) {
                                Text(user.username)

                                Text(user.email)
                                    .foregroundStyle(.gray)
                            }
                        }
                        .font(.subheadline)
                    }
                }

            }
        }
        .task { await viewModel.fetchUsers() }
    }
}

#Preview {
    UsersView()
}
