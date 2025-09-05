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
        NavigationView {
            VStack {
                SearchBar(text: $searchText, onTextChanged: { query in
                    viewModel.search(query: query)
                })
                .padding(.horizontal)

                if viewModel.isLoading {
                    LoadingView()
                } else if let error = viewModel.errorMessage {
                    ErrorView(message: error, retryAction: { viewModel.loadAll() })
                } else if viewModel.planets.isEmpty {
                    EmptyStateView(message: "No planets found")
                } else {
                    List(viewModel.planets) { planet in
                        NavigationLink(destination: PlanetDetailView(planet: planet)) {
                            PlanetRowView(planet: planet)
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("Planets")
        }
        .onAppear {
            viewModel.loadAll()
        }
    }
}
