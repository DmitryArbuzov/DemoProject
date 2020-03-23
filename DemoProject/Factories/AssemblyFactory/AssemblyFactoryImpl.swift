//
//  AssemblyFactoryImpl.swift
//  DemoProject
//
//  Created by Dmitry Arbuzov on 07.03.2020.
//  Copyright © 2020 dm. All rights reserved.
//

import Foundation

final class AssemblyFactoryImpl {

    private let serviceFactory: ServiceFactory

    init(serviceFactory: ServiceFactory) {
        self.serviceFactory = serviceFactory
    }
}

// MARK: - AssemblyFactory
extension AssemblyFactoryImpl: AssemblyFactory {

    func repositoriesList() -> RepositoriesListAssembly {
        RepositoriesListAssemblyImpl(assemblyFactory: self, serviceFactory: serviceFactory)
    }

    func repositoryInfo() -> RepositoryInfoAssembly {
        RepositoryInfoAssemblyImpl(assemblyFactory: self, serviceFactory: serviceFactory)
    }
}
