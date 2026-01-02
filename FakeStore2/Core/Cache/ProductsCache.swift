//
//  ProductsCache.swift
//  FakeStore2
//
//  Created by Eric on 02/01/2026.
//

import Foundation

struct ProductsCache {
    private let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    private let fileName = "products.json"

    func getProducts() throws -> [Product]? {
        guard let fileURL = documentDirectoryURL?.appending(path: fileName) else {
            return nil
        }
        guard FileManager.default.fileExists(atPath: fileURL.path) else { return nil }
        let data = try Data(contentsOf: fileURL)
        return try JSONDecoder().decode([Product].self, from: data)
    }

    func saveProducts(_ products: [Product]) {
        guard let fileURL = documentDirectoryURL?.appending(path: fileName) else {
            return
        }

        do {
            let data = try JSONEncoder().encode(products)
            try data.write(to: fileURL)
        } catch {
            print("Failed to save products to cache...")
        }
    }

    func invalidateCache() {
        guard let fileURL = documentDirectoryURL?.appending(path: fileName) else {
            return
        }

        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch {
            print("Failed to delete cache...")
        }
    }

}
