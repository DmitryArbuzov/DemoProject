//
//  RepositoryInfoAssembly.swift
//  DemoProject
//
//  Created by Dmitry Arbuzov on 17.03.2020.
//  Copyright © 2020 dm. All rights reserved.
//

import Foundation

protocol RepositoryInfoAssembly {
    func module(repositoryURL: URL) -> Module
}
