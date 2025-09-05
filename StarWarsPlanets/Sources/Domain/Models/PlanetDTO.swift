//
//  PlanetDTO.swift
//  StarWarsPlanets
//
//  Created by Dinitha Gamage on 2025-09-05.
//

import Foundation

public struct PlanetDTO: Codable, Identifiable, Equatable, Hashable {
    public let name: String
    public let climate: String
    public let orbitalPeriod: String
    public let gravity: String
    public let url: String?

    public var id: String {
        if let url = url, !url.isEmpty { return url }
        return name
    }
    
    public var seedSafe: String {
        let raw = url?.replacingOccurrences(of: "https://", with: "")
            .replacingOccurrences(of: "/", with: "-")
            .replacingOccurrences(of: ":", with: "-") ?? name
        return raw
            .components(separatedBy: CharacterSet.alphanumerics.inverted)
            .joined(separator: "-")
            .lowercased()
    }

    // Map snake_case keys to Swift camelCase properties where needed
    private enum CodingKeys: String, CodingKey {
        case name
        case climate
        case orbitalPeriod = "orbital_period"
        case gravity
        case url
    }

    public static func == (lhs: PlanetDTO, rhs: PlanetDTO) -> Bool {
        lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.climate == rhs.climate &&
        lhs.orbitalPeriod == rhs.orbitalPeriod &&
        lhs.gravity == rhs.gravity
    }
}
