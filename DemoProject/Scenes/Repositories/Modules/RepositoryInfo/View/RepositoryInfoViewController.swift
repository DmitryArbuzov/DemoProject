//
//  RepositoryInfoViewController.swift
//  DemoProject
//
//  Created by Dmitry Arbuzov on 19.03.2020.
//  Copyright © 2020 dm. All rights reserved.
//

import UIKit

final class RepositoryInfoViewController: BaseViewController, LoadingViewPresentable, ServiceViewPresentable {

    var loadingView: SimpleLoadingView?
    var serviceView: UIView?

    private let output: RepositoryInfoViewOutput
    private let infoLabel = UILabel()

    init(output: RepositoryInfoViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()

        output.viewDidLoad()
    }

    private func setupViews() {
        setupInfoLabel()
    }

    private func setupInfoLabel() {
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(infoLabel)

        infoLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        infoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        infoLabel.textAlignment = .center
        infoLabel.font = .preferredFont(forTextStyle: .largeTitle)
        infoLabel.tintColor = Color.tint
    }
}

// MARK: - RepositoryInfoViewInput
extension RepositoryInfoViewController: RepositoryInfoViewInput {

    func updateState(_ state: RepositoryInfoViewState) {
        switch state {
        case .data(let viewModel):
            hideServiceView()
            hideLoadingView()
            infoLabel.text = viewModel.repositoryName
            title = viewModel.repositoryName
        case .loading:
            hideServiceView()
            showLoadingView(with: .init(title: "   Loading..."))
        case .error(let description):
            hideLoadingView()
            showServiceView(ofType: SimpleErrorView.self, with: .init(description: description))
        }
    }
}
