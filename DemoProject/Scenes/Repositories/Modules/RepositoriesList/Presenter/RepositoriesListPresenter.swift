//
//  RepositoriesListPresenter.swift
//  DemoProject
//
//  Created by Dmitry Arbuzov on 12.03.2020.
//  Copyright © 2020 dm. All rights reserved.
//

import UIKit

final class RepositoriesListPresenter {

    private enum Constants {
        static let pageSize = 20
    }

    private var query = ""
    private var repositories = [RepositoryListCellModel]()
    private var overallRepositoriesCount = 0
    private var isLoading = false

    private let vcsService: VCSService

    weak var view: RepositoriesListViewInput?
    var router: RepositoriesListRouterInput!

    init(vcsService: VCSService) {
        self.vcsService = vcsService
    }

    private func obtainNextPage() {
        let page = repositories.count / Constants.pageSize
        obtainPage(page)
    }

    private func obtainPage(_ page: Int) {
        guard isLoading == false, nextPageExists() else {
            return
        }

        isLoading = true

        vcsService.findRepositories(
            query: query,
            page: page,
            perPage: Constants.pageSize,
            completion: { [weak self] (result) in
                guard let self = self else {
                    return
                }

                switch result {
                case .success(let responseModel):
                    let newCellModels = self.cellModels(from: responseModel.items)
                    DispatchQueue.main.async {
                        self.isLoading = false
                        if page == 0 {
                            self.repositories = []
                        }
                        self.repositories.append(contentsOf: newCellModels)
                        self.overallRepositoriesCount = responseModel.totalCount
                        self.view?.updateState(.data(viewModel: self.makeViewModel()))
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.isLoading = false
                        if page == 0 {
                            self.view?.updateState(.error(description: error.localizedDescription))
                        } else {
                            self.view?.updateState(.data(viewModel: self.makeViewModel()))
                            self.router.showAlert(text: error.localizedDescription)
                        }
                    }
                }
            }
        )
    }

    private func nextPageExists() -> Bool {
        repositories.count < overallRepositoriesCount || repositories.count == 0
    }

    private func color(forLanguage language: String?) -> UIColor? {
        guard
            let language = language,
            let languageColorHEX = GitHubColors.colors[language]
        else {
            return nil
        }
        return UIColor(hexString: languageColorHEX)
    }

    private func cellModels(from repositories: [Repository]) -> [RepositoryListCellModel] {
        repositories.map { (repository) in
            RepositoryListCellModel(
                onSelectHandler: { [weak router = self.router] in
                     router?.openRepositoryInfo(by: repository.url)
                },
                title: repository.name,
                description: repository.description ?? "",
                starsCount: repository.stargazersCount,
                forksCount: repository.forksCount,
                language: repository.language ?? "Unknown",
                languageColor: color(forLanguage: repository.language),
                authorAvatar: repository.owner.avatarUrl
            )
        }
    }

    private func makeViewModel() -> RepositoriesListViewModel {
        .init(items: self.repositories, overallFound: self.overallRepositoriesCount, query: self.query)
    }
}

// MARK: - RepositoriesListViewOutput
extension RepositoriesListPresenter: RepositoriesListViewOutput {

    func didTriggerRefresh() {
        obtainPage(0)
    }

    func queryWasChanged(newQuery: String) {
        query = newQuery
        view?.updateState(.loading)
        obtainPage(0)
    }

    func viewWantsNextPage() {
        obtainNextPage()
    }
}
