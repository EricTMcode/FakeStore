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

extension Product {
    static let mockProducts: [Product] = [
        Product(
            id: 1,
            title: "Wireless Noise-Cancelling Headphones",
            price: 299.99,
            description: "Experience immersive sound with cutting-edge noise cancellation technology. Up to 30 hours of battery life",
            category: "Electronics",
            image: "https://picsum.photos/200/200"
        ),
        Product(
            id: 2,
            title: "Ergonomic Office Chair",
            price: 189.99,
            description: "Designed for all-day comfort, our ergonomic office chair features adjustable lumbar support and a breathable mesh backrest. Perfect for long work hours",
            category: "Furniture",
            image: "https://picsum.photos/200/200"
        ),
        Product(
            id: 3,
            title: "Smartwatch Series 7",
            price: 399.99,
            description: "Track your fitness activities, stay connected with family and friends, and access a wealth of features with our latest smartwatch series 7.",
            category: "Wearables",
            image: "https://picsum.photos/200/200"
        ),
        Product(
            id: 4,
            title: "4K Ultra HD Smart TV",
            price: 599.99,
            description: "Enjoy stunning visuals woth HDR support and built-in straming apps for endless entertainement.",
            category: "Electronics",
            image: "https://picsum.photos/200/200"
        ),
        Product(
            id: 5,
            title: "Ergonomic Office Chair",
            price: 189.99,
            description: "Designed for all-day comfort, our ergonomic office chair features adjustable lumbar support and a breathable mesh backrest. Perfect for long work hours",
            category: "Furniture",
            image: "https://picsum.photos/200/200"
        ),
        Product(
            id: 6,
            title: "Standing Desk Converter",
            price: 129.99,
            description: "Transform any table into a standing desk with our adjustable converter. Easy height adjustments and a spacious surface for monitors and laptops.",
            category: "Furniture",
            image: "https://picsum.photos/200/200"
        ),
        Product(
            id: 7,
            title: "LED Desk Lamp",
            price: 39.99,
            description: "A sleek and modern LED desk lamp with touch controls, adjustable brightness, and color temperature. Ideal for workspaces and study areas.",
            category: "Lighting",
            image: "https://picsum.photos/200/200"
        ),
        Product(
            id: 8,
            title: "Noise-Cancelling Headphones",
            price: 249.99,
            description: "Experience immersive sound with our premium noise-cancelling headphones. Perfect for focus, travel, and relaxation.",
            category: "Electronics",
            image: "https://picsum.photos/200/200"
        ),
        Product(
            id: 9,
            title: "Portable Monitor",
            price: 179.99,
            description: "Expand your workspace anywhere with this lightweight and portable 15.6-inch monitor. USB-C and HDMI compatible.",
            category: "Electronics",
            image: "https://picsum.photos/200/200"
        ),
        Product(
            id: 10,
            title: "Memory Foam Seat Cushion",
            price: 49.99,
            description: "Upgrade any chair with our memory foam seat cushion. Provides excellent support and helps relieve pressure on your lower back.",
            category: "Accessories",
            image: "https://picsum.photos/200/200"
        )
    ]
}
