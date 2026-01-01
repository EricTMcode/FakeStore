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

    init() {
        self.users = User.mockUsers
    }
}
