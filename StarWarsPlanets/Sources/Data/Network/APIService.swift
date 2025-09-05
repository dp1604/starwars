//
//  APIService.swift
//  StarWarsPlanets
//
//  Created by Dinitha Gamage on 2025-09-05.
//

import Foundation

final class APIService {
    private let network: NetworkService

    init(network: NetworkService) {
        self.network = network
    }

    func fetchAllPlanets() async throws -> [PlanetDTO] {
        let endpoint = Endpoint(path: "planets")
        return try await network.request(endpoint.url)
    }
}
