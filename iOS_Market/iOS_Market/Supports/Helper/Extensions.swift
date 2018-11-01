//
//  Extensions.swift
//  iOS_Market
//
//  Created by Dipang Sheth on 31/10/18.
//  Copyright © 2018 Dipang Sheth. All rights reserved.
//

import Foundation
import UIKit

//MARK: - Color Extension Hex to Rgb color code
extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) { cString.removeFirst() }
        if ((cString.count) != 6) {
            self.init(hex: "ffffff") // return white color for wrong hex input
            return
        }
        var rgbValue: UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
}
