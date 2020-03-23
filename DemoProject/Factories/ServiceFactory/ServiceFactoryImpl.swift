//
//  ServiceFactoryImpl.swift
//  DemoProject
//
//  Created by Dmitry Arbuzov on 05.03.2020.
//  Copyright © 2020 dm. All rights reserved.
//

import Foundation

final class ServiceFactoryImpl { }

// MARK: - ServiceFactory
extension ServiceFactoryImpl: ServiceFactory {

    func vcsService() -> VCSService {
        GitHubAPIService(
            networkClient: NetworkClientImpl(
                urlRequestBuilder: URLRequestBuilderImpl(
                    baseURL: Constants.gitHubAPIBaseURL
                )
            )
        )
    }
}
