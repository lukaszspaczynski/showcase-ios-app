//
//  DarkAppStyle+Colors.swift
//  ShowcaseApp
//
//  Created by Lukasz Spaczynski on 23/11/2021.
//

import UIKit

extension DarkAppStyle {
    enum Colors: ColorConvertible {
        case black
        case lightBlack
        case white
        case chalk

        var color: UIColor {
            switch self {
            case .lightBlack:
                return #colorLiteral(red: 0.1647058824, green: 0.1607843137, blue: 0.1843137255, alpha: 1)
            case .black:
                return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .white:
                return #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            case .chalk:
                return #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1)
            }
        }

        func withAlpha(_ alpha: CGFloat) -> ColorConvertible {
            let color = self.color.withAlphaComponent(alpha)

            return ColorContainer(color: color)
        }
    }
}
