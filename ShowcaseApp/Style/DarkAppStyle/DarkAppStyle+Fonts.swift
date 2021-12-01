//
//  DarkAppStyle+Fonts.swift
//  ShowcaseApp
//
//  Created by Lukasz Spaczynski on 23/11/2021.
//

import UIKit

extension DarkAppStyle {
    enum Fonts: FontConvertible {
        case headline(CGFloat)
        case subheadline(CGFloat)

        var fontName: String {
            switch self {
            case .headline:
                return "Menlo-Regular"
            case .subheadline:
                return "Menlo-Regular"
            }
        }

        var fontSize: CGFloat {
            switch self {
            case let .headline(size):
                return size
            case let .subheadline(size):
                return size
            }
        }
    }
}
