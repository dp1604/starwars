//
//  PlanetEntity.swift
//  StarWarsPlanets
//
//  Created by Dinitha Gamage on 2025-09-05.
//

import SwiftData

@Model
final class PlanetEntity {
    @Attribute(.unique) var id: String
    var name: String
    var climate: String
    var orbitalPeriod: String
    var gravity: String
    var url: String?

    init(id: String, name: String, climate: String, orbitalPeriod: String, gravity: String, url: String? = nil) {
        self.id = id
        self.name = name
        self.climate = climate
        self.orbitalPeriod = orbitalPeriod
        self.gravity = gravity
        self.url = url
    }
}
