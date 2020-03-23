//
//  BaseAssembly.swift
//  DemoProject
//
//  Created by Dmitry Arbuzov on 08.03.2020.
//  Copyright © 2020 dm. All rights reserved.
//

import Foundation

class BaseAssembly {
    let assemblyFactory: AssemblyFactory
    let serviceFactory: ServiceFactory

    init(assemblyFactory: AssemblyFactory, serviceFactory: ServiceFactory) {
        self.assemblyFactory = assemblyFactory
        self.serviceFactory = serviceFactory
    }
}
