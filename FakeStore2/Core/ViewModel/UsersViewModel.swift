//
//  UsersViewModel.swift
//  FakeStore2
//
//  Created by Eric on 01/01/2026.
//

import Foundation

@Observable
class UsersViewModel {
    var loadingState: ContentLoadingState<User> = .loading
    private let service: UserServiceProtocol

    init(service: UserServiceProtocol = UserService()) {
        self.service = service
    }

    func fetchUsers() async {
        do {
            let users = try await service.fetchUsers()
            self.loadingState = users.isEmpty ? .empty : .completed(data: users)
        } catch {
            self.loadingState = .error(error: error)
        }
    }

    func refreshUsers() async {
        do {
            let users = try await service.refreshUsers()
            self.loadingState = users.isEmpty ? .empty : .completed(data: users)
        } catch {
            self.loadingState = .error(error: error)
        }
    }
}
