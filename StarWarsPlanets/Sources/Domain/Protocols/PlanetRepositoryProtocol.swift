//
//  PlanetRepositoryProtocol.swift
//  StarWarsPlanets
//
//  Created by Dinitha Gamage on 2025-09-05.
//

protocol PlanetRepositoryProtocol {
    func fetchAllPlanets() async throws -> [PlanetDTO]
    func searchPlanets(query: String) async throws -> [PlanetDTO]
    func fetchNextPage() async throws -> [PlanetDTO]
    func resetPagination() async
    func fetchCachedPlanets(filter: String?) async throws -> [PlanetDTO]
}
