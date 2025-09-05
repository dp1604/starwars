//
//  AppError.swift
//  StarWarsPlanets
//
//  Created by Dinitha Gamage on 2025-09-05.
//

import Foundation

enum AppError: Error {
    case network(NetworkError)
    case persistence
    case unknown

    var userMessage: String {
        switch self {
        case .network(let netErr):
            return netErr.userMessage
        case .persistence:
            return "A storage error occurred."
        case .unknown:
            return "Something went wrong. Please try again."
        }
    }
}
