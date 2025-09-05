//
//  PlanetCard.swift
//  StarWarsPlanets
//
//  Created by Dinitha Gamage on 2025-09-05.
//

import SwiftUI

struct PlanetCard: View {
    let planet: PlanetDTO

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            RemoteImageView(url: URL(string: "https://picsum.photos/seed/\(planet.id)/300"))
                .frame(height: 160)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .shadow(radius: 4)

            Text(planet.name)
                .font(.headline)

            Text("Climate: \(planet.climate)")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}
