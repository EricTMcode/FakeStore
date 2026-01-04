//
//  FakeStoreAPIEndpoint.swift
//  FakeStore2
//
//  Created by Eric on 04/01/2026.
//

import Foundation

enum FakeStoreAPIEndpoint {
    case products
    case users

    var path: String {
        switch self {
        case .products:
            return "/products"
        case .users:
            return "/users"
        }
    }
}
