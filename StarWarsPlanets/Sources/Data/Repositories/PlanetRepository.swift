//
//  PlanetRepository.swift
//  StarWarsPlanets
//
//  Created by Dinitha Gamage on 2025-09-05.
//

import Foundation
import SwiftData

actor PlanetRepository: PlanetRepositoryProtocol {
    private let api = APIService.shared
    private let context: ModelContext
    private var currentPage: Int = 1

    init(context: ModelContext) {
        self.context = context
    }

    // MARK: - Public API

    func fetchAllPlanets() async throws -> [PlanetDTO] {
        let url = URL(string: "https://swapi.info/api/planets")!
        do {
            let remote: [PlanetDTO] = try await NetworkClient.shared.request(url)
            try await saveToCache(remote)
            return remote
        } catch {
            return try await fetchCachedPlanets()
        }
    }

    func searchPlanets(query: String) async throws -> [PlanetDTO] {
        let url = URL(string: "https://swapi.info/api/planets?search=\(query)")!
        do {
            let remote: [PlanetDTO] = try await NetworkClient.shared.request(url)
            try await saveToCache(remote)
            return remote
        } catch {
            return try await fetchCachedPlanets(filter: query)
        }
    }

    func fetchNextPage() async throws -> [PlanetDTO] {
        // Example if API supports pagination
        let nextPage = currentPage + 1
        let url = URL(string: "https://swapi.info/api/planets?page=\(nextPage)")!
        let remote: [PlanetDTO] = try await NetworkClient.shared.request(url)
        try await saveToCache(remote)
        currentPage = nextPage
        return remote
    }

    func resetPagination() async {
        currentPage = 1
    }

    // MARK: - Persistence

    private func saveToCache(_ dtos: [PlanetDTO]) async throws {
        try await context.transaction {
            for dto in dtos {
                let descriptor = FetchDescriptor<PlanetEntity>(
                    predicate: #Predicate { $0.id == dto.id }
                )
                if let existing = try? context.fetch(descriptor).first {
                    existing.name = dto.name
                    existing.climate = dto.climate
                    existing.orbitalPeriod = dto.orbitalPeriod
                    existing.gravity = dto.gravity
                    existing.url = dto.url
                } else {
                    let entity = PlanetEntity(
                        id: dto.id,
                        name: dto.name,
                        climate: dto.climate,
                        orbitalPeriod: dto.orbitalPeriod,
                        gravity: dto.gravity,
                        url: dto.url
                    )
                    context.insert(entity)
                }
            }
        }
    }

    func fetchCachedPlanets(filter: String? = nil) async throws -> [PlanetDTO] {
        let descriptor: FetchDescriptor<PlanetEntity>
        if let filter = filter, !filter.isEmpty {
            descriptor = FetchDescriptor<PlanetEntity>(
                predicate: #Predicate { $0.name.localizedStandardContains(filter) },
                sortBy: [SortDescriptor(\.name)]
            )
        } else {
            descriptor = FetchDescriptor<PlanetEntity>(
                sortBy: [SortDescriptor(\.name)]
            )
        }

        let entities = try context.fetch(descriptor)
        return entities.map {
            PlanetDTO(
                name: $0.name,
                climate: $0.climate,
                orbitalPeriod: $0.orbitalPeriod,
                gravity: $0.gravity,
                url: $0.url
            )
        }
    }
}
