//
//  HTTPResponseValidator.swift
//  FakeStore2
//
//  Created by Eric on 04/01/2026.
//

import Foundation

struct HTTPResponseValidator {
    func validateResponse(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }

        guard httpResponse.statusCode == 200 else {
            throw APIError.invalidResponse
        }
    }
}
