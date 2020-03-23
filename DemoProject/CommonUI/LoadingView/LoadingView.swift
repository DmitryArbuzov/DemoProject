//
//  LoadingView.swift
//  DemoProject
//
//  Created by Dmitry Arbuzov on 21.03.2020.
//  Copyright © 2020 dm. All rights reserved.
//

import UIKit

protocol LoadingView: UIView {
    associatedtype Model: LoadingViewModel

    func update(with model: Model)
}
