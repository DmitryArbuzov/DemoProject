//
//  RepositoryInfoAssemblyImpl.swift
//  DemoProject
//
//  Created by Dmitry Arbuzov on 17.03.2020.
//  Copyright © 2020 dm. All rights reserved.
//

import UIKit

final class RepositoryInfoAssemblyImpl: BaseAssembly { }

// MARK: - RepositoryInfoAssembly
extension RepositoryInfoAssemblyImpl: RepositoryInfoAssembly {

    func module(repositoryURL: URL) -> Module {
        let presenter = RepositoryInfoPresenter(repositoryURL: repositoryURL, vcsService: serviceFactory.vcsService())
        let view = RepositoryInfoViewController(output: presenter)
        presenter.view = view

        return .init(viewController: view)
    }
}
