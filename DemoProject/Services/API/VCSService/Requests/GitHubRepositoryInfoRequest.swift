//
//  GitHubRepositoryInfoRequest.swift
//  DemoProject
//
//  Created by Dmitry Arbuzov on 17.03.2020.
//  Copyright © 2020 dm. All rights reserved.
//

import Foundation

struct GitHubRepositoryInfoRequest: APIRequest {
    typealias Response = Repository

    let baseURL: URL?
    let path: String

    init(repositoryUrl: URL) {
        baseURL = repositoryUrl.baseURL
        path = repositoryUrl.path
    }
}
