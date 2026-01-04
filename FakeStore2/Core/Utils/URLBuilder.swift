//
//  URLBuilder.swift
//  FakeStore2
//
//  Created by Eric on 04/01/2026.
//

import Foundation

struct URLBuilder {
    private let baseURL: String
    private let endpoint: FakeStoreAPIEndpoint

    init(baseURL: String, endpoint: FakeStoreAPIEndpoint) {
        self.baseURL = baseURL
        self.endpoint = endpoint
    }

    func buildURL() throws -> URL {
        guard var components = URLComponents(string: baseURL) else { throw APIError.invalidURL }
        components.path = endpoint.path

        guard let url = components.url else { throw APIError.invalidURL }

        return url
    }
}
