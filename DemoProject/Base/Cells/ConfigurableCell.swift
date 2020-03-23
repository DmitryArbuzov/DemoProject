//
//  ConfigurableCell.swift
//  DemoProject
//
//  Created by Dmitry Arbuzov on 05.03.2020.
//  Copyright © 2020 dm. All rights reserved.
//

import UIKit

protocol ConfigurableCell: UICollectionViewCell, ReusableCell {
    static func height(with model: CellModel, forWidth width: CGFloat) -> CGFloat

    func configure(with model: CellModel)
}
