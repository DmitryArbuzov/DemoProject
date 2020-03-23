//
//  ReusableCell.swift
//  DemoProject
//
//  Created by Dmitry Arbuzov on 22.03.2020.
//  Copyright © 2020 dm. All rights reserved.
//

import Foundation

protocol ReusableCell {
    static var reuseIdentifier: String { get }
}

extension ReusableCell {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}
