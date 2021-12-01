//
//  Style.swift
//  ShowcaseApp
//
//  Created by Lukasz Spaczynski on 23/11/2021.
//

import UIKit

protocol Style {
    var headline: FontConvertible { get }
    var headlineTextColor: ColorConvertible { get }
    var subheadline: FontConvertible { get }
    var subheadlineTextColor: ColorConvertible { get }
    var primatyButtonTextColor: ColorConvertible { get }
    var primatyButtonDisabledTextColor: ColorConvertible { get }
    var animationDuration: Double { get }
}

protocol StyleApplicable {
    associatedtype StyleType

    func apply(style: StyleType)
}

protocol AppStyle:
    WelcomeAppStyle {}

extension UIButton: StyleApplicable {
    typealias StyleType = Style

    func apply(style: StyleType) {
        setColors(
            (style.primatyButtonTextColor.color,
             style.primatyButtonDisabledTextColor.color))
    }
}

extension UIButton {
    typealias MainColorsType = (normal: UIColor, disabled: UIColor)

    func setColors(_ c: MainColorsType) {
        setTitleColor(c.normal, for: .normal)
        setTitleColor(c.disabled, for: .disabled)
    }
}
