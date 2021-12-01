//
//  FontConvertible.swift
//  ShowcaseApp
//
//  Created by Lukasz Spaczynski on 23/11/2021.
//

import UIKit

protocol FontConvertible {
    var fontName: String { get }
    var fontSize: CGFloat { get }
    var font: UIFont { get }
}

extension FontConvertible {
    var font: UIFont {
        UIFont(name: fontName, size: fontSize)!
    }
}
