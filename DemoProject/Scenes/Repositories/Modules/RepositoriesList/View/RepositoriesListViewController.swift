//
//  ViewController.swift
//  DemoProject
//
//  Created by Dmitry Arbuzov on 04.03.2020.
//  Copyright © 2020 dm. All rights reserved.
//

import UIKit

// В проде будет некоторая иерархия базовых контроллеров. А dataSource коллекции будет помещен в отдельный класс
final class RepositoriesListViewController: BaseViewController, LoadingViewPresentable, ServiceViewPresentable {

    var loadingView: SimpleLoadingView?
    var serviceView: UIView?

    private let flowLayout = CustomFlowLayout()
    private var collectionView: UICollectionView!
    private let output: RepositoriesListViewOutput
    private var cellModels = [CellModel]() // Упрощено до ячеек. В общем решении будет использован массив [SectionModel]

    init(output: RepositoriesListViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()

        output.queryWasChanged(newQuery: "Swift")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if collectionView.refreshControl == nil {
            setupRefreshControl()
        }
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        collectionView.collectionViewLayout.invalidateLayout()
    }

    private func setupViews() {
        setupCollectionView()
    }

    private func setupCollectionView() {
        collectionView = .init(frame: .zero, collectionViewLayout: flowLayout)

        view.addSubview(collectionView)
        collectionView.addConstraintsToSuperviewEdges()

        collectionView.backgroundColor = Color.background

        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.register(RepositoryListCell.self, forCellWithReuseIdentifier: RepositoryListCell.reuseIdentifier)
    }

    private func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = Color.tint
        refreshControl.addTarget(self, action: #selector(didTriggerRefresh), for: .valueChanged)
        collectionView.refreshControl = refreshControl
        collectionView.refreshControl?.layer.zPosition = -1
    }

    @objc private func didTriggerRefresh() {
        output.didTriggerRefresh()
    }

    private func showErrorView(text: String) {
        showServiceView(ofType: SimpleErrorView.self, with: SimpleErrorViewModel(description: text))
    }

    private func hideRefreshControl() {
        if collectionView.refreshControl?.isRefreshing == true {
            DispatchQueue.main.async {
                self.collectionView.refreshControl?.endRefreshing()
            }
        }
    }

    private func updateTitle(query: String, found: Int) {
        title = "Query: \(query), Found: \(found)"
    }

    private func applyNewViewModel(_ viewModel: RepositoriesListViewModel) {
        // !!! Просто костыль для демо красивой анимации вставки
        // В проде на этом этапе нужно items(sections) прогнать через diff алгоритм и применить анимированные апдейты
        // Например, https://github.com/onmyway133/DeepDiff
        let cellsDiffCount = viewModel.items.count - cellModels.count
        cellModels = viewModel.items
        let cellsCount = cellModels.count

        if cellsDiffCount >= 0 {
            let insertedIndexPaths = ((cellsCount - cellsDiffCount)..<cellsCount).map {
                IndexPath(item: $0, section: 0)
            }
            collectionView.performBatchUpdates({
                collectionView.insertItems(at: insertedIndexPaths)
            }, completion: nil)
        } else {
            collectionView.reloadData()
        }

        updateTitle(query: viewModel.query, found: viewModel.overallFound)
    }
}

// MARK: - UICollectionViewDataSource
extension RepositoriesListViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellModels.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cellModel = cellModels[indexPath.item]
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: cellModel.cellClass.reuseIdentifier,
            for: indexPath
        )
        if let cell = cell as? ConfigurableCell {
            cell.configure(with: cellModel)
        }

        return cell
    }

    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        if indexPath.item == cellModels.count - 6 {
            output.viewWantsNextPage()
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension RepositoriesListViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let cellModel = cellModels[indexPath.item]
        let cellWidth = flowLayout.cellWidth
        let cellHeight = cellModel.cellClass.height(with: cellModel, forWidth: cellWidth)
        return CGSize(width: cellWidth, height: cellHeight)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cellModel = cellModels[indexPath.item]
        collectionView.deselectItem(at: indexPath, animated: true)
        cellModel.onSelectHandler?()
    }
}

// MARK: - RepositoriesListViewInput
extension RepositoriesListViewController: RepositoriesListViewInput {

    func updateState(_ state: RepositoriesListViewState) {
        switch state {
        case .data(let viewModel):
            applyNewViewModel(viewModel)
            hideRefreshControl()
            hideServiceView()
            hideLoadingView()
        case .loading:
            hideServiceView()
            showLoadingView(with: .init(title: "   Loading..."))
        case .error(let description):
            hideRefreshControl()
            hideLoadingView()
            showErrorView(text: description)
        }
    }
}
