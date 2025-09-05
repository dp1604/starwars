//
//  PlanetListViewModelTests.swift
//  StarWarsPlanetsTests
//
//  Created by Dinitha Gamage on 2025-09-05.
//

import XCTest
@testable import StarWarsPlanets

@MainActor
final class PlanetListViewModelTests: XCTestCase {
    var mockRepo: MockPlanetRepository!
    var viewModel: PlanetListViewModel!

    override func setUp() {
        super.setUp()
        mockRepo = MockPlanetRepository()
        viewModel = PlanetListViewModel(repository: mockRepo)
    }

    override func tearDown() {
        mockRepo = nil
        viewModel = nil
        super.tearDown()
    }

    func testLoadAllSuccess() async {
        // Arrange
        mockRepo.planetsToReturn = [
            PlanetDTO(name: "Tatooine", climate: "Arid", orbitalPeriod: "304", gravity: "1", url: "1"),
            PlanetDTO(name: "Alderaan", climate: "Temperate", orbitalPeriod: "364", gravity: "1 standard", url: "2")
        ]

        // Act
        viewModel.loadAll()
        try? await Task.sleep(nanoseconds: 500_000_000) // wait for async

        // Assert
        XCTAssertEqual(viewModel.planets.count, 2)
        XCTAssertNil(viewModel.errorMessage)
    }

    func testLoadAllFailureFallsBackToError() async {
        // Arrange
        mockRepo.shouldThrowError = true

        // Act
        viewModel.loadAll()
        try? await Task.sleep(nanoseconds: 500_000_000)

        // Assert
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertTrue(viewModel.planets.isEmpty)
    }

    func testSearchFiltersPlanets() async {
        // Arrange
        mockRepo.planetsToReturn = [
            PlanetDTO(name: "Tatooine", climate: "Arid", orbitalPeriod: "304", gravity: "1", url: "1"),
            PlanetDTO(name: "Alderaan", climate: "Temperate", orbitalPeriod: "364", gravity: "1 standard", url: "2")
        ]
        viewModel.loadAll()
        try? await Task.sleep(nanoseconds: 500_000_000)

        // Act
        viewModel.search(query: "Tat")
        try? await Task.sleep(nanoseconds: 500_000_000)

        // Assert
        XCTAssertEqual(viewModel.planets.count, 1)
        XCTAssertEqual(viewModel.planets.first?.name, "Tatooine")
    }
}
