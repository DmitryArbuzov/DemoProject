//
//  RepositoryListCellModel.swift
//  DemoProject
//
//  Created by Dmitry Arbuzov on 05.03.2020.
//  Copyright © 2020 dm. All rights reserved.
//

import UIKit

struct RepositoryListCellModel: CellModel {
    let cellClass: ConfigurableCell.Type = RepositoryListCell.self
    var onSelectHandler: (() -> Void)?

    let title: String
    let description: String
    let starsCount: UInt
    let forksCount: UInt
    let language: String
    let languageColor: UIColor?
    let authorAvatar: URL?
}
