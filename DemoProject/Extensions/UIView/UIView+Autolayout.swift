//
//  UIView+Autolayout.swift
//  DemoProject
//
//  Created by Dmitry Arbuzov on 21.03.2020.
//  Copyright © 2020 dm. All rights reserved.
//

import UIKit

extension UIView {

    func addConstraintsToSuperviewEdges() {
        guard let superview = superview else {
            return
        }
        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        ])
    }
}
