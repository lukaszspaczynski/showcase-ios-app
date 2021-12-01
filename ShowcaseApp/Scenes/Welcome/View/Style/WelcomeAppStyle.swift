//
//  WelcomeAppStyle.swift
//  ShowcaseApp
//
//  Created by Lukasz Spaczynski on 23/11/2021.
//

import UIKit

protocol WelcomeAppStyle: Style {
    var welcomeStyle: WelcomeStyle { get }
}

struct WelcomeStyle {
    let backgroundColor: ColorConvertible
}
