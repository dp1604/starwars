//
//  PlanetRepositoryProtocol.swift
//  StarWarsPlanets
//
//  Created by Dinitha Gamage on 2025-09-05.
//

protocol PlanetRepositoryProtocol {
    func fetchAllPlanets() async throws -> [PlanetDTO]
    func searchPlanets(query: String) async throws -> [PlanetDTO]
    func fetchCachedPlanets(filter: String?) async throws -> [PlanetDTO]
}
