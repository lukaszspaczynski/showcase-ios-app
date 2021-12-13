//
//  WelcomeBioViewController+StyleApplicable.swift
//  ShowcaseApp
//
//  Created by Lukasz Spaczynski on 23/11/2021.
//

import UIKit

extension WelcomeBioViewController: StyleApplicable {
    typealias StyleType = WelcomeAppStyle

    func apply(style: StyleType) {
        view.backgroundColor = style.welcomeStyle.backgroundColor.color
        viewActivityIndicator.color = style.headlineTextColor.color

        buttonNext.apply(style: style)
        buttonPrev.apply(style: style)
    }
}
