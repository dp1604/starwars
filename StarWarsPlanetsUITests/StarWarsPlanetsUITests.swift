//
//  StarWarsPlanetsUITests.swift
//  StarWarsPlanetsUITests
//
//  Created by Dinitha Gamage on 2025-09-06.
//

import Foundation
import XCTest

final class StarWarsPlanetsUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("--UITest")
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testPlanetsListLoads() throws {
        let planetsList = app.tables["PlanetsList"]
        let firstRow = planetsList.cells.firstMatch
        XCTAssertTrue(firstRow.waitForExistence(timeout: 30), "The planets list should load at least one row")
    }

    func testPlanetDetailsView() throws {
        let planetsList = app.tables["PlanetsList"]
        let firstRow = planetsList.cells.firstMatch
        XCTAssertTrue(firstRow.waitForExistence(timeout: 30))
        firstRow.tap()

        // Check detail labels
        let planetName = app.staticTexts["PlanetName_Tatooine"]
        XCTAssertTrue(planetName.waitForExistence(timeout: 20))

        let orbitalPeriod = app.staticTexts["OrbitalPeriod_Tatooine"]
        XCTAssertTrue(orbitalPeriod.exists)

        let gravity = app.staticTexts["Gravity_Tatooine"]
        XCTAssertTrue(gravity.exists)
    }
}
