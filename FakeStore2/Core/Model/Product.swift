//
//  Product.swift
//  FakeStore2
//
//  Created by Eric on 01/01/2026.
//

import Foundation

struct Product: Codable, Identifiable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
}
