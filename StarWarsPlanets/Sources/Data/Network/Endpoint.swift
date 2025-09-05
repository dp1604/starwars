//
//  Endpoint.swift
//  StarWarsPlanets
//
//  Created by Dinitha Gamage on 2025-09-05.
//

import Foundation

/// Represents an API endpoint with path and query items
struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]

    init(path: String, queryItems: [URLQueryItem] = []) {
        self.path = path
        self.queryItems = queryItems
    }

    /// Construct the full URL for the endpoint
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "swapi.info"
        components.path = "/api/\(path)"
        if !queryItems.isEmpty {
            components.queryItems = queryItems
        }
        guard let url = components.url else {
            fatalError("Invalid URL components for endpoint: \(path)")
        }
        return url
    }
}
