//
//  PlanetDTO.swift
//  StarWarsPlanets
//
//  Created by Dinitha Gamage on 2025-09-05.
//

import Foundation

/// DTO representing a Planet from SWAPI
/// Keeps property names matching the API so decoding is straightforward.
public struct PlanetDTO: Codable, Identifiable, Equatable {
    public let name: String
    public let climate: String
    public let orbitalPeriod: String
    public let gravity: String
    public let url: String? // SWAPI often provides a `url` field which can be used as stable id

    // Conform to Identifiable — prefer `url` if available, otherwise use `name`
    public var id: String {
        if let url = url, !url.isEmpty { return url }
        return name
    }

    // Map snake_case keys to Swift camelCase properties where needed
    private enum CodingKeys: String, CodingKey {
        case name
        case climate
        case orbitalPeriod = "orbital_period"
        case gravity
        case url
    }

    // Equatable conformance synthesized is fine, but explicit implementation keeps intent clear
    public static func == (lhs: PlanetDTO, rhs: PlanetDTO) -> Bool {
        lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.climate == rhs.climate &&
        lhs.orbitalPeriod == rhs.orbitalPeriod &&
        lhs.gravity == rhs.gravity
    }
}
