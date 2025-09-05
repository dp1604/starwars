//
//  MockPlanetRepository.swift
//  StarWarsPlanetsTests
//
//  Created by Dinitha Gamage on 2025-09-05.
//

import Foundation
@testable import StarWarsPlanets

final class MockPlanetRepository: PlanetRepositoryProtocol {
    var planetsToReturn: [PlanetDTO] = []
    var shouldThrowError: Bool = false

    func fetchAllPlanets() async throws -> [PlanetDTO] {
        if shouldThrowError {
            throw AppError.network(.invalidResponse)
        }
        return planetsToReturn
    }

    func searchPlanets(query: String) async throws -> [PlanetDTO] {
        if shouldThrowError {
            throw AppError.network(.invalidResponse)
        }
        return planetsToReturn.filter { $0.name.lowercased().contains(query.lowercased()) }
    }

    func fetchCachedPlanets(filter: String?) async throws -> [PlanetDTO] {
        return planetsToReturn
    }
}
