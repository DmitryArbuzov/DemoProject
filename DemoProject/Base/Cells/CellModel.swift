//
//  CellModel.swift
//  DemoProject
//
//  Created by Dmitry Arbuzov on 22.03.2020.
//  Copyright © 2020 dm. All rights reserved.
//

import UIKit

protocol CellModel {
    typealias OnSelectHandler = () -> Void

    var cellClass: ConfigurableCell.Type { get }
    var onSelectHandler: (() -> Void)? { get }
}
