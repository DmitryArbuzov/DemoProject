//
//  RepositoriesListRouter.swift
//  DemoProject
//
//  Created by Dmitry Arbuzov on 23.03.2020.
//  Copyright © 2020 dm. All rights reserved.
//

import UIKit

final class RepositoriesListRouter: BaseRouter {
}

extension RepositoriesListRouter: RepositoriesListRouterInput {

    func openRepositoryInfo(by url: URL) {
        let repositoryInfoVC = assemblyFactory.repositoryInfo().module(repositoryURL: url).viewController
        viewController.navigationController?.pushViewController(repositoryInfoVC, animated: true)
    }

    func showAlert(text: String) {
        let alert = UIAlertController(title: text, message: nil, preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .default))
        viewController.present(alert, animated: true)
    }
}
