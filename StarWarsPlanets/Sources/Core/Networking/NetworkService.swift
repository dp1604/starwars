//
//  NetworkService.swift
//  StarWarsPlanets
//
//  Created by Dinitha Gamage on 2025-09-05.
//

import Foundation

protocol NetworkService {
    func request<T: Decodable>(_ url: URL) async throws -> T
}
