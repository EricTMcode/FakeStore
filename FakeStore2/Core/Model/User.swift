//
//  User.swift
//  FakeStore2
//
//  Created by Eric on 01/01/2026.
//

import Foundation

struct User: Codable, Identifiable, Equatable {
    let id: Int
    let username: String
    let email: String
}

extension User {
    static let mockUsers: [User] = [
        User(id: 1, username: "johndoe", email: "johndoe@example.com"),
        User(id: 2, username: "janedoe", email: "janedoe@example.com"),
        User(id: 3, username: "alice", email: "alice@example.com"),
        User(id: 4, username: "bobsmith", email: "bobsmith@example.com"),
        User(id: 5, username: "charlie", email: "charlie@example.com"),
        User(id: 6, username: "davidlee", email: "davidlee@example.com"),
        User(id: 7, username: "emily", email: "emily@example.com"),
        User(id: 8, username: "frankwhite", email: "frankwhite@example.com"),
        User(id: 9, username: "gracehopper", email: "gracehopper@example.com"),
        User(id: 10, username: "henryford", email: "henryford@example.com")
    ]
}
