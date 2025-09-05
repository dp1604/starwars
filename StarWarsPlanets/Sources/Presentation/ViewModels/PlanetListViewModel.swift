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
                let fetched = try await repository.fetchAllPlanets()
                allPlanets = fetched
                planets = fetched
                errorMessage = nil
            } catch {
                let appError = (error as? AppError) ?? .unknown

                do {
                    let cached = try await repository.fetchCachedPlanets(filter: nil)
                    allPlanets = cached
                    planets = cached
                    if cached.isEmpty {
                        errorMessage = "Failed to connect to internet.\nNo cached data available"
                    }
                } catch {
                    let appError = (error as? AppError) ?? .unknown
                    errorMessage = appError.userMessage
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

            let lowercasedQuery = query.lowercased()
            planets = allPlanets.filter { $0.name.lowercased().contains(lowercasedQuery) }
        }
    }
}
