//
//  GitHubFindRepositoriesRequest.swift
//  DemoProject
//
//  Created by Dmitry Arbuzov on 14.03.2020.
//  Copyright © 2020 dm. All rights reserved.
//

import Foundation

struct GitHubFindRepositoriesRequest: APIRequest {
    typealias Response = SearchRepositoriesResponse

    let path: String = "search/repositories"
    let parameters: [String: String]?

    init(query: String, page: Int, perPage: Int) {
        parameters = [
            "q": query,
            "page": String(page),
            "per_page": String(perPage),
            "sort": "stars"
        ]
    }
}
