//
//  MockUserService.swift
//  FakeStore2
//
//  Created by Eric on 05/01/2026.
//


import Foundation

struct MockUserService: UserServiceProtocol {
    var mockUsers = User.mockUsers
    var errorToThrow: Error?

    func refreshUsers() async throws -> [User] {
        if let errorToThrow { throw errorToThrow }
        return mockUsers
    }
    
    func fetchUsers() async throws -> [User] {
        if let errorToThrow { throw errorToThrow }
        return mockUsers
    }
}
