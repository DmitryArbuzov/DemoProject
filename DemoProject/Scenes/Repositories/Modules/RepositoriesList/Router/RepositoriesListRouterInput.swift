//
//  RepositoriesListRouterInput.swift
//  DemoProject
//
//  Created by Dmitry Arbuzov on 23.03.2020.
//  Copyright © 2020 dm. All rights reserved.
//

import Foundation

protocol RepositoriesListRouterInput: AnyObject {
    func openRepositoryInfo(by url: URL)
    func showAlert(text: String)
}
