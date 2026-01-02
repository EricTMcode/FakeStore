//
//  CacheManager.swift
//  FakeStore2
//
//  Created by Eric on 02/01/2026.
//

import Foundation

protocol CacheManagerProtocol {
    func getData<T: Codable>(as type: T.Type) throws -> [T]
    func saveData<T: Codable>(_ data: [T])
    func invalidate()

    var filename: String { get }
}

struct CacheManager: CacheManagerProtocol {
    let filename: String

    init(filename: String) {
        self.filename = filename
    }
}

extension CacheManagerProtocol {
    var documentDirectoryURL: URL? {
        return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
    }

    func getData<T: Codable>(as type: T.Type) throws -> [T] {
        guard let fileURL = documentDirectoryURL?.appending(path: filename) else {
            return []
        }
        guard FileManager.default.fileExists(atPath: fileURL.path) else { return [] }
        let data = try Data(contentsOf: fileURL)
        return try JSONDecoder().decode([T].self, from: data)
    }

    func saveData<T: Codable>(_ data: [T]) {
        guard let fileURL = documentDirectoryURL?.appending(path: filename) else {
            return
        }

        do {
            let data = try JSONEncoder().encode(data)
            try data.write(to: fileURL)
        } catch {
            print("Failed to save products to cache...")
        }
    }

    func invalidate() {
        guard let fileURL = documentDirectoryURL?.appending(path: filename) else {
            return
        }

        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch {
            print("Failed to delete cache...")
        }
    }
}
