//
//  Repository.swift
//  DemoProject
//
//  Created by Dmitry Arbuzov on 04.03.2020.
//  Copyright © 2020 dm. All rights reserved.
//

import Foundation

struct Repository: Codable {
    let id: Int
    let name: String
    let description: String?
    let stargazersCount: UInt
    let forksCount: UInt
    let language: String?
    let owner: RepositoryOwner
    let url: URL
}
