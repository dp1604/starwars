//
//  APIServiceTests.swift
//  StarWarsPlanetsTests
//
//  Created by Dinitha Gamage on 2025-09-05.
//

import XCTest
@testable import StarWarsPlanets

final class APIServiceTests: XCTestCase {
    func testFetchAllPlanetsSuccess() async throws {
        let mockNetwork = MockNetworkService()
        mockNetwork.result = [PlanetDTO(name: "Dagobah", climate: "Murky", orbitalPeriod: "341", gravity: "N/A", url: "3")]
        let service = APIService(network: mockNetwork)

        let planets = try await service.fetchAllPlanets()

        XCTAssertEqual(planets.count, 1)
        XCTAssertEqual(planets.first?.name, "Dagobah")
    }

    func testFetchAllPlanetsFailure() async {
        let mockNetwork = MockNetworkService()
        mockNetwork.shouldThrowError = true
        let service = APIService(network: mockNetwork)

        do {
            _ = try await service.fetchAllPlanets()
            XCTFail("Expected failure")
        } catch {
            XCTAssertTrue(error is NetworkError)
        }
    }
}
