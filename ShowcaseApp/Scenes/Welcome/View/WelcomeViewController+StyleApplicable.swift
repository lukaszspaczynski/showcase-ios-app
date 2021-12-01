//
//  WelcomeViewController+StyleApplicable.swift
//  ShowcaseApp
//
//  Created by Lukasz Spaczynski on 23/11/2021.
//

extension WelcomeViewController: StyleApplicable {
    typealias StyleType = WelcomeAppStyle

    func apply(style: StyleType) {
        view.backgroundColor = style.welcomeStyle.backgroundColor.color
    }
}
