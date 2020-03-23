//
//  BaseRouter.swift
//  DemoProject
//
//  Created by Dmitry Arbuzov on 23.03.2020.
//  Copyright © 2020 dm. All rights reserved.
//

import UIKit

class BaseRouter {
    let assemblyFactory: AssemblyFactory
    let viewController: UIViewController

    init(assemblyFactory: AssemblyFactory, viewController: UIViewController) {
        self.assemblyFactory = assemblyFactory
        self.viewController = viewController
    }
}
