//
//  PlanetRepository.swift
//  StarWarsPlanets
//
//  Created by Dinitha Gamage on 2025-09-05.
//

import Foundation
import SwiftData

@MainActor
final class PlanetRepository: PlanetRepositoryProtocol {
    private let api: APIService
    private let context: ModelContext
    private var currentPage: Int = 1

    init(context: ModelContext, api: APIService) {
        self.context = context
        self.api = api
    }

    func fetchAllPlanets() async throws -> [PlanetDTO] {
        do {
            let remote = try await api.fetchAllPlanets()
            try saveToCache(remote)
            return remote
        } catch let net as NetworkError {
            throw AppError.network(net)
        } catch let app as AppError {
            throw app
        } catch {
            throw AppError.unknown
        }
    }

    func searchPlanets(query: String) async throws -> [PlanetDTO] {
        do {
            return try await fetchCachedPlanets(filter: query)
        } catch let app as AppError {
            throw app
        } catch {
            throw AppError.persistence
        }
    }

    private func saveToCache(_ dtos: [PlanetDTO]) throws {
        do {
            try context.transaction {
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
        } catch {
            throw AppError.persistence
        }
    }

    func fetchCachedPlanets(filter: String? = nil) async throws -> [PlanetDTO] {
        do {
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
        } catch let app as AppError {
            throw app
        } catch {
            throw AppError.persistence
        }
    }
}
