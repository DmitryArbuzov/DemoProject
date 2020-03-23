//
//  GitHubAPIService.swift
//  DemoProject
//
//  Created by Dmitry Arbuzov on 04.03.2020.
//  Copyright © 2020 dm. All rights reserved.
//

import Foundation

protocol VCSService {

    func findRepositories(
        query: String,
        page: Int,
        perPage: Int,
        completion: @escaping (Result<SearchRepositoriesResponse, APIError>) -> Void
    )

    func obtainRepositoryInfo(by url: URL, completion: @escaping (Result<Repository, APIError>) -> Void)
}
