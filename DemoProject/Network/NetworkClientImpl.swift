//
//  NetworkClientImpl.swift
//  DemoProject
//
//  Created by Dmitry Arbuzov on 10.03.2020.
//  Copyright © 2020 dm. All rights reserved.
//

import Foundation

final class NetworkClientImpl {

    private let session = URLSession(configuration: .default, delegate: nil, delegateQueue: nil)
    private let constructingQueue = DispatchQueue(label: "\(NetworkClientImpl.self)", qos: .utility)
    private let urlRequestBuilder: URLRequestBuilder

    init(urlRequestBuilder: URLRequestBuilder) {
        self.urlRequestBuilder = urlRequestBuilder
    }
}

// MARK: - NetworkClient
extension NetworkClientImpl: NetworkClient {

    func performRequest<Request: NetworkRequest>(
        _ request: Request,
        completion: @escaping (Result<NetworkResponse, NetworkError>) -> Void
    ) {
        constructingQueue.async { [weak self] in
            guard let self = self else {
                return
            }
            var urlRequest: URLRequest
            do {
                urlRequest = try self.urlRequestBuilder.urlRequest(from: request)
            } catch {
                completion(.failure(.incorrectRequest(error)))
                return
            }

            let task = self.session.dataTask(
                with: urlRequest,
                completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
                    if let error = error {
                        completion(.failure(.underlyingNetworkError(error)))
                    } else if let response = response as? HTTPURLResponse {
                        completion(.success(.init(data: data, response: response)))
                    }
                }
            )
            task.resume()
        }
    }
}
