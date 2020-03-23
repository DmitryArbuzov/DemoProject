//
//  NetworkRequest.swift
//  DemoProject
//
//  Created by Dmitry Arbuzov on 04.03.2020.
//  Copyright © 2020 dm. All rights reserved.
//

import Foundation

protocol NetworkRequest {
    associatedtype Parameters: Encodable = String

    typealias HTTPHeaders = [String: String]
    typealias CachePolicy = URLRequest.CachePolicy

    var baseURL: URL? { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: Parameters? { get }
    var headers: HTTPHeaders? { get }
    var cachePolicy: CachePolicy { get }
    var encoding: ParameterEncoding { get }
    var timeoutInterval: TimeInterval { get }
}

extension NetworkRequest {
    var baseURL: URL? {
        nil
    }

    var method: HTTPMethod {
        .get
    }

    var parameters: Parameters? {
        nil
    }

    var headers: HTTPHeaders? {
        nil
    }

    var cachePolicy: CachePolicy {
        .useProtocolCachePolicy
    }

    var encoding: ParameterEncoding {
        .formURL
    }

    var timeoutInterval: TimeInterval {
        60.0
    }
}
