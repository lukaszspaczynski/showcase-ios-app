//
//  WelcomePage1ViewController+StyleApplicable.swift
//  ShowcaseApp
//
//  Created by Lukasz Spaczynski on 23/11/2021.
//

import UIKit

extension WelcomePage1ViewController: StyleApplicable {
    typealias StyleType = WelcomeAppStyle

    func apply(style: StyleType) {
        view.backgroundColor = style.welcomeStyle.backgroundColor.color
        labelHeader.textColor = style.headlineTextColor.color

        buttonNext.apply(style: style)
    }
}
