//
//  ContentLoadingState.swift
//  FakeStore2
//
//  Created by Eric on 02/01/2026.
//

import Foundation

enum ContentLoadingState<T: Codable> {
    case loading
    case empty
    case error(error: Error)
    case completed(data: [T])
}
