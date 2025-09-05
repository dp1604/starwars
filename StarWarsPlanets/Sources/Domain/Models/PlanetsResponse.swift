//
//  PlanetsResponse.swift
//  StarWarsPlanets
//
//  Created by Dinitha Gamage on 2025-09-05.
//

import Foundation

/// Response object for paginated planets list from SWAPI
public struct PlanetsResponse: Codable {
    public let results: [PlanetDTO]
    public let next: String?
    public let previous: String?

    private enum CodingKeys: String, CodingKey {
        case results
        case next
        case previous
    }
}
