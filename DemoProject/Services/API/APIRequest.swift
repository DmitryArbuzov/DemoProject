//
//  APIRequest.swift
//  DemoProject
//
//  Created by Dmitry Arbuzov on 14.03.2020.
//  Copyright © 2020 dm. All rights reserved.
//

import Foundation

protocol APIRequest: NetworkRequest {
    associatedtype Response: Decodable
}
