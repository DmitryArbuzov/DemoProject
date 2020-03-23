//
//  RepositoriesListViewInput.swift
//  DemoProject
//
//  Created by Dmitry Arbuzov on 12.03.2020.
//  Copyright © 2020 dm. All rights reserved.
//

import Foundation

protocol RepositoriesListViewInput: AnyObject {
    func updateState(_ state: RepositoriesListViewState)
}
