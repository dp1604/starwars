//
//  NetworkClient.swift
//  StarWarsPlanets
//
//  Created by Dinitha Gamage on 2025-09-05.
//

import Foundation
import Alamofire

/// Centralized network client built on top of Alamofire with async/await support.
final class NetworkClient {
    static let shared = NetworkClient()
    private let session: Session

    private init() {
        // Add custom configuration or interceptors if needed
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 60
        session = Session(configuration: configuration)
    }

    /// Perform a request and decode the response into the given Decodable type.
    func request<T: Decodable>(_ url: URL) async throws -> T {
        return try await withCheckedThrowingContinuation { continuation in
            session.request(url)
                .validate()
                .responseDecodable(of: T.self) { response in
                    print(response.result)
                    switch response.result {
                    case .success(let decoded):
                        continuation.resume(returning: decoded)
                    case .failure(let error):
                        continuation.resume(throwing: NetworkError.afError(error))
                    }
                }
        }
    }
}
