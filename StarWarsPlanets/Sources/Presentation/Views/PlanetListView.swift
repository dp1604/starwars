//
//  PlanetListView.swift
//  StarWarsPlanets
//
//  Created by Dinitha Gamage on 2025-09-05.
//

import SwiftUI

struct PlanetListView: View {
    @StateObject private var viewModel: PlanetListViewModel
    @State private var searchText: String = ""

    init(viewModel: PlanetListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    LoadingView()
                } else if let error = viewModel.errorMessage {
                    ErrorView(message: error) { viewModel.loadAll() }
                } else if viewModel.planets.isEmpty {
                    EmptyStateView(message: "No planets found")
                } else {
                    List(viewModel.planets) { planet in
                        NavigationLink(value: planet) {
                            PlanetRowView(planet: planet)
                        }
                        .accessibilityIdentifier("PlanetRow_\(planet.name)")
                    }
                    .listStyle(.plain)
                    .accessibilityIdentifier("PlanetsList")
                }
            }
            .navigationTitle("Planets")
            .searchable(text: $searchText)
            .onChange(of: searchText) { viewModel.search(query: $0) }
            .refreshable { viewModel.loadAll() }
            .task { viewModel.loadAll() }
            .navigationDestination(for: PlanetDTO.self) { PlanetDetailView(planet: $0) }
        }
    }
}
