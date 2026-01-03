//
//  UserService.swift
//  FakeStore2
//
//  Created by Eric on 02/01/2026.
//

import Foundation

protocol UserServiceProtocol {
    func fetchUsers() async throws -> [User]
}

struct UserService: UserServiceProtocol {
    private let downloader: HTTPDataDownloaderProtocol

    init(downloader: HTTPDataDownloaderProtocol = HTTPDataDownloader(endpoint: .users, cache: CacheManager(filename: "users.json"))) {
        self.downloader = downloader
    }

    func fetchUsers() async throws -> [User] {
        return try await downloader.fetchData(as: User.self)
    }

}

struct MockUserService: UserServiceProtocol {
    func fetchUsers() async throws -> [User] {
        return User.mockUsers
    }
}
