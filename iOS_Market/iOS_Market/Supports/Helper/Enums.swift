//
//  Enums.swift
//  iOS_Market
//
//  Created by Dipang Sheth on 31/10/18.
//  Copyright © 2018 Dipang Sheth. All rights reserved.
//

import Foundation
import UIKit

//MARK: - Specific Color Code
enum Colors {
    case WildSand, Silver, SteelGray, Gallery, White
    func color() -> UIColor {
        switch self {
        case .WildSand:
            return UIColor(hex: "#f5f5f5")
        case .Silver:
            return UIColor(hex: "#c6c6c6")
        case .SteelGray:
            return UIColor(hex: "#1d1d28")
        case .Gallery:
            return UIColor(hex: "#eaeaea")
        case .White:
            return UIColor(hex: "#ffffff")
        }
    }
}
