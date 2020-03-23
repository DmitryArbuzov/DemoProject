//
//  UIColor+HEX.swift
//  DemoProject
//
//  Created by Dmitry Arbuzov on 18.03.2020.
//  Copyright © 2020 dm. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init?(hexString: String) {
        var colorString = hexString
        if colorString.hasPrefix("#") {
            colorString.remove(at: colorString.startIndex)
        }

        if colorString.count != 6 {
            return nil
        }

        var rgbValue: UInt64 = 0
        Scanner(string: colorString).scanHexInt64(&rgbValue)

        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: 1)
    }
}
