//
//  LoadingViewPresentable.swift
//  DemoProject
//
//  Created by Dmitry Arbuzov on 21.03.2020.
//  Copyright © 2020 dm. All rights reserved.
//

import UIKit

protocol LoadingViewPresentable: UIViewController {
    associatedtype LoadingViewType: LoadingView

    var loadingView: LoadingViewType? { get set }

    func showLoadingView(with model: LoadingViewType.Model)
    func hideLoadingView()
}

extension LoadingViewPresentable {

    func showLoadingView(with model: LoadingViewType.Model) {
        let loadingView = LoadingViewType()
        view.addSubview(loadingView)
        loadingView.addConstraintsToSuperviewEdges()

        loadingView.update(with: model)

        self.loadingView = loadingView
    }

    func hideLoadingView() {
        guard loadingView != nil else {
            return
        }

        loadingView?.removeFromSuperview()
        loadingView = nil
    }
}
