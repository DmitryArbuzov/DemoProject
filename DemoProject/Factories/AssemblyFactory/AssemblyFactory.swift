//
//  AssemblyFactory.swift
//  DemoProject
//
//  Created by Dmitry Arbuzov on 07.03.2020.
//  Copyright © 2020 dm. All rights reserved.
//

import Foundation

protocol AssemblyFactory {
    func repositoriesList() -> RepositoriesListAssembly
    func repositoryInfo() -> RepositoryInfoAssembly
}
