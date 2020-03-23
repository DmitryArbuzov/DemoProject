//
//  RepositoriesListViewState.swift
//  DemoProject
//
//  Created by Dmitry Arbuzov on 22.03.2020.
//  Copyright © 2020 dm. All rights reserved.
//

import Foundation

enum RepositoriesListViewState {
    case data(viewModel: RepositoriesListViewModel)
    case loading
    case error(description: String)
}
