//
//  Colors.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 10/10/2022.
//

import UIKit

enum ColorProvider: String {
    case primary
    case onPrimary
    case surface
    case secondary
    case tableSurface
}

extension UIColor {
    static func appColor(name: ColorProvider) -> UIColor?{
        return UIColor(named: name.rawValue)
    }
}
