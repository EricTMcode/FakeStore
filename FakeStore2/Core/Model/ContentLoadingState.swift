//
//  ContentLoadingState.swift
//  FakeStore2
//
//  Created by Eric on 02/01/2026.
//

import Foundation

enum ContentLoadingState {
    case loading
    case empty
    case error(error: Error)
    case completed
}
