//
//  PlanetListViewModel.swift
//  StarWarsPlanets
//
//  Created by Dinitha Gamage on 2025-09-05.
//

import Foundation

@MainActor
final class PlanetListViewModel: ObservableObject {
    @Published var planets: [PlanetDTO] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let repository: PlanetRepositoryProtocol
    private var fetchTask: Task<Void, Never>?
    private var searchTask: Task<Void, Never>?

    // Keep a local copy of the full list for searching
    private var allPlanets: [PlanetDTO] = []

    init(repository: PlanetRepositoryProtocol) {
        self.repository = repository
    }

    func loadAll() {
        fetchTask?.cancel()
        searchTask?.cancel()

        fetchTask = Task {
            isLoading = true
            defer { isLoading = false }
            do {
                await repository.resetPagination()
                let fetched = try await repository.fetchAllPlanets()
                allPlanets = fetched
                planets = fetched
            } catch {
                // Offline fallback
                errorMessage = (error as? AppError)?.userMessage ?? "Failed to fetch from API, loading cached data..."
                do {
                    // Try to load cached planets from SwiftData
                    let cached = try await repository.fetchCachedPlanets(filter: nil)
                    allPlanets = cached
                    planets = cached
                    if cached.isEmpty {
                        errorMessage = "No cached data available"
                    }
                } catch {
                    errorMessage = "Failed to load planets"
                }
            }
        }
    }

    func search(query: String) {
        searchTask?.cancel()
        searchTask = Task {
            try? await Task.sleep(nanoseconds: 300_000_000) // 300ms debounce
            guard !Task.isCancelled else { return }

            if query.isEmpty {
                planets = allPlanets
                return
            }

            // Perform in-memory filtering
            let lowercasedQuery = query.lowercased()
            planets = allPlanets.filter { $0.name.lowercased().contains(lowercasedQuery) }
        }
    }
}
