//
//  APIService.swift
//  StarWarsPlanets
//
//  Created by Dinitha Gamage on 2025-09-05.
//

import Foundation

/// Service layer responsible for calling SWAPI endpoints
final class APIService {
    static let shared = APIService()
    private init() {}

    /// Fetch one page of planets
    func fetchPlanetsPage(url: URL) async throws -> PlanetsResponse {
        try await NetworkClient.shared.request(url)
    }

    /// Fetch all planets, traversing paginated results until `next` is nil
    func fetchAllPlanets() async throws -> [PlanetDTO] {
        var all: [PlanetDTO] = []
        var nextURL: URL? = Endpoint(path: "planets").url

        while let url = nextURL {
            let page: PlanetsResponse = try await fetchPlanetsPage(url: url)
            all.append(contentsOf: page.results)
            nextURL = page.next.flatMap { URL(string: $0) }
        }

        return all
    }

    /// Search planets by name
    func searchPlanets(query: String) async throws -> [PlanetDTO] {
        let endpoint = Endpoint(
            path: "planets",
            queryItems: [URLQueryItem(name: "search", value: query)]
        )
        let response: PlanetsResponse = try await NetworkClient.shared.request(endpoint.url)
        return response.results
    }
}
