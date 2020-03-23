//
//  ServiceView.swift
//  DemoProject
//
//  Created by Dmitry Arbuzov on 21.03.2020.
//  Copyright © 2020 dm. All rights reserved.
//

import UIKit

protocol ServiceView: UIView {
    associatedtype Model: ServiceViewModel

    func update(with model: Model)
}
