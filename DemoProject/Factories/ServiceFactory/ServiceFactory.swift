//
//  ServiceFactory.swift
//  DemoProject
//
//  Created by Dmitry Arbuzov on 05.03.2020.
//  Copyright © 2020 dm. All rights reserved.
//

import Foundation

protocol ServiceFactory {

    func vcsService() -> VCSService
}
