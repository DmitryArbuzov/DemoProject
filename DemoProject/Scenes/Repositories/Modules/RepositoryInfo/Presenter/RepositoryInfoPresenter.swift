//
//  RepositoryInfoPresenter.swift
//  DemoProject
//
//  Created by Dmitry Arbuzov on 19.03.2020.
//  Copyright © 2020 dm. All rights reserved.
//

import Foundation

final class RepositoryInfoPresenter {

    private let repositoryURL: URL
    private let vcsService: VCSService
    weak var view: RepositoryInfoViewInput?

    init(repositoryURL: URL, vcsService: VCSService) {
        self.repositoryURL = repositoryURL
        self.vcsService = vcsService
    }
}

// MARK: - RepositoryInfoViewOutput
extension RepositoryInfoPresenter: RepositoryInfoViewOutput {

    func viewDidLoad() {
        view?.updateState(.loading)
        vcsService.obtainRepositoryInfo(by: repositoryURL) { [weak view] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let repository):
                    view?.updateState(.data(viewModel: .init(repositoryName: repository.name)))
                case .failure(let error):
                    view?.updateState(.error(description: error.localizedDescription))
                }
            }
        }
    }
}
