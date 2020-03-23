//
//  URLRequestBuilderImpl.swift
//  DemoProject
//
//  Created by Dmitry Arbuzov on 17.03.2020.
//  Copyright © 2020 dm. All rights reserved.
//

import Foundation

final class URLRequestBuilderImpl {

    private let baseURL: URL

    init(baseURL: URL) {
        self.baseURL = baseURL
    }
}

// MARK: - URLRequestBuilder
extension URLRequestBuilderImpl: URLRequestBuilder {

    func urlRequest<Request: NetworkRequest>(from request: Request) throws -> URLRequest {
        guard
            var url = URL(string: request.path, relativeTo: request.baseURL ?? baseURL),
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        else {
            throw URLRequestBuilderError.unableToCreateURL
        }

        // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        // На этом этапе очень много кода надо написать(или использовать Alamofire) для корректной поддержки
        // всех HTTPMethods, ParameterEncoding и Encodable parameters.
        // Беру для демо просто случай get c formURLEncoded в query и приведение параметров к [String: String]
        if request.method == .get, let parameters = request.parameters as? [String: String] {
            let queryItemsFromParameters = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
            urlComponents.queryItems = (urlComponents.queryItems ?? []) + queryItemsFromParameters
            guard let newURL = urlComponents.url else {
                throw URLRequestBuilderError.unableToCreateURL
            }
            url = newURL
        }

        var urlRequest = URLRequest(url: url)

        urlRequest.httpMethod = request.method.rawValue
        urlRequest.cachePolicy = request.cachePolicy
        urlRequest.timeoutInterval = request.timeoutInterval

        if let headers = request.headers {
            for (headerField, headerValue) in headers {
                urlRequest.setValue(headerValue, forHTTPHeaderField: headerField)
            }
        }

        return urlRequest
    }
}
