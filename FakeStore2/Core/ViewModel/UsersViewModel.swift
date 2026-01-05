//
//  UsersViewModel.swift
//  FakeStore2
//
//  Created by Eric on 01/01/2026.
//

import Foundation

@Observable
class UsersViewModel {
    var users = [User]()
    var loadingState: ContentLoadingState = .loading
    private let service: UserServiceProtocol

    init(service: UserServiceProtocol = UserService()) {
        self.service = service
    }

    func fetchUsers() async {
        do {
            self.users = try await service.fetchUsers()
            self.loadingState = users.isEmpty ? .empty : .completed
        } catch {
            self.loadingState = .error(error: error)
        }
    }

    func refreshUsers() async {
        do {
            self.users = try await service.refreshUsers()
            self.loadingState = users.isEmpty ? .empty : .completed
        } catch {
            self.loadingState = .error(error: error)
        }
    }
}
