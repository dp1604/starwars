//
//  PlanetRowView.swift
//  StarWarsPlanets
//
//  Created by Dinitha Gamage on 2025-09-05.
//

import SwiftUI

struct PlanetRowView: View {
    let planet: PlanetDTO

    var body: some View {
        HStack(spacing: 16) {
            RemoteImageView(url: URL(string: "https://picsum.photos/seed/\(planet.seedSafe)/60/60"))
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 6))

            VStack(alignment: .leading, spacing: 4) {
                Text(planet.name)
                    .font(.headline)
                    .accessibilityIdentifier("PlanetName_\(planet.name)")
                
                Text("Climate: \(planet.climate)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .accessibilityIdentifier("PlanetClimate_\(planet.name)")
            }

            Spacer()
        }
        .padding(.vertical, 8)
    }
}
