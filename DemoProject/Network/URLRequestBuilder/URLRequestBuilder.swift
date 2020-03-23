//
//  URLRequestBuilder.swift
//  DemoProject
//
//  Created by Dmitry Arbuzov on 17.03.2020.
//  Copyright © 2020 dm. All rights reserved.
//

import Foundation

protocol URLRequestBuilder {
    func urlRequest<Request: NetworkRequest>(from request: Request) throws -> URLRequest
}
