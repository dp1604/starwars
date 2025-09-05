//
//  StarWarsPlanetsApp.swift
//  StarWarsPlanets
//
//  Created by Dinitha Gamage on 2025-09-05.
//

import SwiftUI
import SwiftData

@main
struct StarWarsPlanetsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentViewWrapper()
        }
        .modelContainer(for: PlanetEntity.self)
    }
}

struct ContentViewWrapper: View {
    @Environment(\.modelContext) private var context

    var body: some View {
        let repo = PlanetRepository(context: context)
        PlanetListView(viewModel: PlanetListViewModel(repository: repo))
    }
}
