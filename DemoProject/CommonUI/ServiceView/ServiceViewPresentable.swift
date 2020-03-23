//
//  ServiceViewPresentable.swift
//  DemoProject
//
//  Created by Dmitry Arbuzov on 21.03.2020.
//  Copyright © 2020 dm. All rights reserved.
//

import UIKit

protocol ServiceViewPresentable: UIViewController {
    var serviceView: UIView? { get set }

    func showServiceView<ServiceView, Model>(
        ofType viewType: ServiceView.Type, with model: Model
    ) where ServiceView: DemoProject.ServiceView, Model == ServiceView.Model

    func hideServiceView()
}

extension ServiceViewPresentable {

   func showServiceView<ServiceView, Model>(
        ofType viewType: ServiceView.Type, with model: Model
    ) where ServiceView: DemoProject.ServiceView, Model == ServiceView.Model {
        let serviceView = ServiceView()
        view.addSubview(serviceView)
        serviceView.addConstraintsToSuperviewEdges()

        serviceView.update(with: model)

        self.serviceView = serviceView
    }

    func hideServiceView() {
        guard serviceView != nil else {
            return
        }

        serviceView?.removeFromSuperview()
        serviceView = nil
    }
}
