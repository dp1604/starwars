//
//  PlanetDetailView.swift
//  StarWarsPlanets
//
//  Created by Dinitha Gamage on 2025-09-05.
//

import SwiftUI

struct PlanetDetailView: View {
    let planet: PlanetDTO

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                RemoteImageView(url: URL(string: "https://picsum.photos/seed/\(planet.seedSafe)/400/250"))
                    .frame(maxWidth: .infinity)
                    .shadow(radius: 5)
                    .padding(.top)

                VStack(alignment: .leading, spacing: 12) {
                    Text(planet.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .accessibilityIdentifier("PlanetName_\(planet.name)")

                    HStack {
                        Text("Orbital Period:")
                            .fontWeight(.semibold)
                        Text(planet.orbitalPeriod)
                            .accessibilityIdentifier("OrbitalPeriod_\(planet.name)")
                    }

                    HStack {
                        Text("Gravity:")
                            .fontWeight(.semibold)
                        Text(planet.gravity)
                            .accessibilityIdentifier("Gravity_\(planet.name)")
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
        }
        .navigationTitle(planet.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
