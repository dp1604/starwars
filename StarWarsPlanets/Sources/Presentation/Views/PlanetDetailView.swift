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
                RemoteImageView(url: URL(string: "https://picsum.photos/seed/\(planet.id.replacingOccurrences(of: "/", with: ""))/400/250"))
                    .frame(width: UIScreen.main.bounds.width)
                    .shadow(radius: 5)
                    .padding(.top)

                VStack(alignment: .leading, spacing: 12) {
                    Text(planet.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    HStack {
                        Text("Climate:")
                            .fontWeight(.semibold)
                        Text(planet.climate)
                    }

                    HStack {
                        Text("Orbital Period:")
                            .fontWeight(.semibold)
                        Text(planet.orbitalPeriod)
                    }

                    HStack {
                        Text("Gravity:")
                            .fontWeight(.semibold)
                        Text(planet.gravity)
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
