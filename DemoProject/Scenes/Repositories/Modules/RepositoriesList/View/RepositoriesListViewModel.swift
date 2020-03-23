//
//  RepositoriesListViewModel.swift
//  DemoProject
//
//  Created by Dmitry Arbuzov on 22.03.2020.
//  Copyright © 2020 dm. All rights reserved.
//

import Foundation

struct RepositoriesListViewModel {
    let items: [CellModel]
    let overallFound: Int
    let query: String
}
