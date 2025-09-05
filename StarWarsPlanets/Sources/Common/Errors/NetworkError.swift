//
//  NetworkError.swift
//  StarWarsPlanets
//
//  Created by Dinitha Gamage on 2025-09-05.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case invalidResponse
    case decodingFailed
    case afError(AFError)
    case unknown(Error)

    var userMessage: String {
        switch self {
        case .invalidResponse:
            return "Invalid server response."
        case .decodingFailed:
            return "Failed to read data from server."
        case .afError(let error):
            return "Network error: \(error.localizedDescription)"
        case .unknown(let error):
            return "Unexpected error: \(error.localizedDescription)"
        }
    }
}
