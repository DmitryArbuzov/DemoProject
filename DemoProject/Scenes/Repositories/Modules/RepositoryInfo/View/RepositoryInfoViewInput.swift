//
//  RepositoryInfoViewInput.swift
//  DemoProject
//
//  Created by Dmitry Arbuzov on 23.03.2020.
//  Copyright © 2020 dm. All rights reserved.
//

import Foundation

protocol RepositoryInfoViewInput: AnyObject {
    func updateState(_ state: RepositoryInfoViewState)
}
