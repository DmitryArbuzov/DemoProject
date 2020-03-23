//
//  RepositoriesListAssemblyImpl.swift
//  DemoProject
//
//  Created by Dmitry Arbuzov on 07.03.2020.
//  Copyright © 2020 dm. All rights reserved.
//

import Foundation

final class RepositoriesListAssemblyImpl: BaseAssembly { }

// MARK: - RepositoriesListAssembly
extension RepositoriesListAssemblyImpl: RepositoriesListAssembly {

    func module() -> Module {
        let presenter = RepositoriesListPresenter(vcsService: serviceFactory.vcsService())
        let view = RepositoriesListViewController(output: presenter)
        let router = RepositoriesListRouter(assemblyFactory: assemblyFactory, viewController: view)
        presenter.view = view
        presenter.router = router

        return .init(viewController: view)
    }
}
