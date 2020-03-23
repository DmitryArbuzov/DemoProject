//
//  BaseAPIService.swift
//  DemoProject
//
//  Created by Dmitry Arbuzov on 04.03.2020.
//  Copyright © 2020 dm. All rights reserved.
//

import Foundation

class BaseAPIService {

    let networkClient: NetworkClient
    let decoder: JSONDecoder

    init(
        networkClient: NetworkClient,
        decoder: JSONDecoder
    ) {
        self.networkClient = networkClient
        self.decoder = decoder
    }

    func performRequest<Request: APIRequest>(
        _ request: Request, completion: @escaping (Result<Request.Response, APIError>) -> Void
    ) {
        networkClient.performRequest(request) { [weak self, decoder] result in
            guard let self = self else {
                return
            }

            switch result {
            case .success(let networkResponse):
                if let validationError = self.validateResponse(networkResponse) {
                    completion(.failure(validationError))
                    return
                }
                guard let data = networkResponse.data else {
                    completion(.failure(.noData))
                    return
                }

                do {
                    let responseModel = try decoder.decode(Request.Response.self, from: data)
                    completion(.success(responseModel))
                } catch let error as DecodingError {
                    completion(.failure(.decoding(error)))
                } catch {
                    completion(.failure(.unknown(error)))
                }
            case .failure(let networkError):
                completion(.failure(.network(networkError)))
            }
        }
    }

    func validateResponse(_ response: NetworkResponse) -> APIError? {
        let statusCode = response.response.statusCode
        guard statusCode >= 200 && statusCode <= 299 else {
            var reason = ""
            if let data = response.data {
                reason = String(data: data, encoding: .utf8) ?? ""
            }
            return APIError.unacceptableStatusCode(code: statusCode, reason: reason)
        }
        return nil
    }
}
