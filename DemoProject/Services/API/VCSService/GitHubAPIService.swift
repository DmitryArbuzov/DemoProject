//
//  GitHubAPIServiceImpl.swift
//  DemoProject
//
//  Created by Dmitry Arbuzov on 04.03.2020.
//  Copyright © 2020 dm. All rights reserved.
//

import Foundation

final class GitHubAPIService: BaseAPIService {

    init(networkClient: NetworkClient) {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        super.init(networkClient: networkClient, decoder: decoder)
    }
}

// MARK: - VCSService
extension GitHubAPIService: VCSService {

    func findRepositories(
        query: String,
        page: Int,
        perPage: Int,
        completion: @escaping (Result<SearchRepositoriesResponse, APIError>) -> Void
    ) {
        let request = GitHubFindRepositoriesRequest(query: query, page: page, perPage: perPage)
        performRequest(request, completion: completion)
    }

    func obtainRepositoryInfo(by url: URL, completion: @escaping (Result<Repository, APIError>) -> Void) {
        let request = GitHubRepositoryInfoRequest(repositoryUrl: url)
        performRequest(request, completion: completion)
    }
}
