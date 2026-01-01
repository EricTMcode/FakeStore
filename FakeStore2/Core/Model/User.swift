//
//  User.swift
//  FakeStore2
//
//  Created by Eric on 01/01/2026.
//

import Foundation

struct User: Codable, Identifiable {
    let id: Int
    let username: String
    let email: String
    let password: String
}
