//
//  ColorConvertible.swift
//  ShowcaseApp
//
//  Created by Lukasz Spaczynski on 23/11/2021.
//

import UIKit

protocol ColorConvertible {
    var color: UIColor { get }
}

struct ColorContainer: ColorConvertible {
    let color: UIColor
}
