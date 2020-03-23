//
//  NetworkError.swift
//  DemoProject
//
//  Created by Dmitry Arbuzov on 04.03.2020.
//  Copyright © 2020 dm. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case incorrectRequest(Error)
    // Этот кейс в проде надо промапить в конкретные ошибки типа .noConnection и пр.
    case underlyingNetworkError(Error)
}
