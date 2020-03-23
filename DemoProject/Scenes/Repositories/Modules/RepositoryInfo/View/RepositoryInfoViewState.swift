//
//  RepositoryInfoViewState.swift
//  DemoProject
//
//  Created by Dmitry Arbuzov on 23.03.2020.
//  Copyright © 2020 dm. All rights reserved.
//

import Foundation

enum RepositoryInfoViewState {
    case data(viewModel: RepositoryInfoViewModel)
    case loading
    case error(description: String)
}
