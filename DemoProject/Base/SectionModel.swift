//
//  SectionModel.swift
//  DemoProject
//
//  Created by Dmitry Arbuzov on 22.03.2020.
//  Copyright © 2020 dm. All rights reserved.
//

import Foundation

struct SectionModel {
    let header: HeaderFooterModel? = nil
    let items: [CellModel]
    let footer: HeaderFooterModel? = nil
}
