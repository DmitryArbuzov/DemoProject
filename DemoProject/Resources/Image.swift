//
//  Image.swift
//  DemoProject
//
//  Created by Dmitry Arbuzov on 09.03.2020.
//  Copyright © 2020 dm. All rights reserved.
//

import UIKit

// В настоящем проекте это должно генерироваться автоматически через SwiftGen
enum Image {
    static var star: UIImage {
        return UIImage(named: "star")!
    }

    static var fork: UIImage {
        return UIImage(named: "fork")!
    }

    static var avatarPlaceholder: UIImage {
        return UIImage(named: "avatarPlaceholder")!
    }
}
