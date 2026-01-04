//
//  CacheManager.swift
//  FakeStore2
//
//  Created by Eric on 02/01/2026.
//

import Foundation

struct CacheManager: CacheManagerProtocol {
    let filename: String

    init(filename: String) {
        self.filename = filename
    }
}
