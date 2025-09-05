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
        mockNetwork.result = [PlanetDTO(name: "Earth", climate: "Wet", orbitalPeriod: "365", gravity: "1", url: "1")]
        let service = APIService(network: mockNetwork)

        let planets = try await service.fetchAllPlanets()

        XCTAssertEqual(planets.count, 1)
        XCTAssertEqual(planets.first?.name, "Earth")
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
