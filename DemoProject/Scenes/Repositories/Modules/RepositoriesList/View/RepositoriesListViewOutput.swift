//
//  RepositoriesListViewOutput.swift
//  DemoProject
//
//  Created by Dmitry Arbuzov on 12.03.2020.
//  Copyright © 2020 dm. All rights reserved.
//

import Foundation

protocol RepositoriesListViewOutput {
    func didTriggerRefresh()
    func queryWasChanged(newQuery: String)
    func viewWantsNextPage()
}
