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
    private let URLString = "https://fakestoreapi.com/users"
    private let refreshInterval: TimeInterval = 60 * 10 // 10 minutes
    private var lastFetchedTime: Date?
    private let downloader: HTTPDataDownloaderProtocol

    init(downloader: HTTPDataDownloaderProtocol = HTTPDataDownloader()) {
        self.downloader = downloader
        getLastFetchedTime()
    }

    func fetchUsers() async throws -> [User] {
        print("DEBUG: Getting users from API")
        let users = try await downloader.fetchData(as: User.self, from: .users)
        saveLastFetchedTime()

        return users
    }

    private func saveLastFetchedTime() {
        UserDefaults.standard.set(Date(), forKey: "lastFetchedTime")
    }

    private mutating func getLastFetchedTime() {
        self.lastFetchedTime = UserDefaults.standard.value(forKey: "lastFetchedTime") as? Date
    }

    private var needsRefresh: Bool {
        guard let lastFetchedTime else { return true }
        print("DEBUG: Last fetched time \(lastFetchedTime)")
        print("DEBUG: Time since \(Date().timeIntervalSince(lastFetchedTime))")
        return Date().timeIntervalSince(lastFetchedTime) >= refreshInterval
    }
}

struct MockUserService: UserServiceProtocol {
    func fetchUsers() async throws -> [User] {
        return User.mockUsers
    }
}
