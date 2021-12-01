//
//  ConcreteAppStyle.swift
//  ShowcaseApp
//
//  Created by Lukasz Spaczynski on 23/11/2021.
//

import UIKit

struct DarkAppStyle: AppStyle, Style {
    let headline: FontConvertible = Fonts.headline(42.0)
    let headlineTextColor: ColorConvertible = Colors.chalk
    let subheadline: FontConvertible = Fonts.subheadline(32.0)
    let subheadlineTextColor: ColorConvertible = Colors.chalk
    let primatyButtonTextColor: ColorConvertible = Colors.chalk
    let primatyButtonDisabledTextColor: ColorConvertible = Colors.chalk.withAlpha(0.5)
    let animationDuration: Double = 0.33
}
