//
//  WelcomePage3ViewController+StyleApplicable.swift
//  ShowcaseApp
//
//  Created by Lukasz Spaczynski on 23/11/2021.
//

extension WelcomePage3ViewController: StyleApplicable {
    typealias StyleType = WelcomeAppStyle

    func apply(style: StyleType) {
        view.backgroundColor = style.welcomeStyle.backgroundColor.color

        buttonPrev.apply(style: style)
        buttonStart.apply(style: style)
    }
}
