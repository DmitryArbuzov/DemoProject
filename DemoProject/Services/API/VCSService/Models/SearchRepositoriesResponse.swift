//
//  SearchRepositoriesResponse.swift
//  DemoProject
//
//  Created by Dmitry Arbuzov on 04.03.2020.
//  Copyright © 2020 dm. All rights reserved.
//

import Foundation

struct SearchRepositoriesResponse: Decodable {
    let totalCount: Int
    let items: [Repository]
}
