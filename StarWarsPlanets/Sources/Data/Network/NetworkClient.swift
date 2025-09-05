//
//  NetworkClient.swift
//  StarWarsPlanets
//
//  Created by Dinitha Gamage on 2025-09-05.
//

import Foundation
import Alamofire

final class NetworkClient: NetworkService {
    private let session: Session

    init(session: Session? = nil) {
        if let session = session {
            self.session = session
        } else {
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = 30
            configuration.timeoutIntervalForResource = 60
            self.session = Session(configuration: configuration)
        }
    }

    func request<T: Decodable>(_ url: URL) async throws -> T {
        return try await withCheckedThrowingContinuation { continuation in
            session.request(url)
                .validate()
                .responseDecodable(of: T.self) { response in
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

