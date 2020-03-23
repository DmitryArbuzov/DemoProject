//
//  NetworkClient.swift
//  DemoProject
//
//  Created by Dmitry Arbuzov on 04.03.2020.
//  Copyright © 2020 dm. All rights reserved.
//

import Foundation

protocol NetworkClient {
    func performRequest<Request: NetworkRequest>(
        _ request: Request,
        completion: @escaping (Result<NetworkResponse, NetworkError>) -> Void
    )
}
