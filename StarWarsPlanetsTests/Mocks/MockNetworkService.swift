//
//  MockNetworkService.swift
//  StarWarsPlanetsTests
//
//  Created by Dinitha Gamage on 2025-09-06.
//

import Foundation
@testable import StarWarsPlanets

final class MockNetworkService: NetworkService {
    var result: Any?
    var shouldThrowError = false

    func request<T>(_ url: URL) async throws -> T where T : Decodable {
        if shouldThrowError {
            throw NetworkError.invalidResponse
        }
        if let result = result as? T {
            return result
        }
        throw NetworkError.invalidResponse
    }
}
