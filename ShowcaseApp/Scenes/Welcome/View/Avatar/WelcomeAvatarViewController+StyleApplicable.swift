//
//  WelcomeAvatarViewController+StyleApplicable.swift
//  ShowcaseApp
//
//  Created by Lukasz Spaczynski on 23/11/2021.
//

extension WelcomeAvatarViewController: StyleApplicable {
    typealias StyleType = WelcomeAppStyle

    func apply(style: StyleType) {
        view.backgroundColor = style.welcomeStyle.backgroundColor.color
        viewActivityIndicator.color = style.headlineTextColor.color

        buttonPrev.apply(style: style)
        buttonNext.apply(style: style)
    }
}
