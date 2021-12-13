//
//  WelcomeAvatarViewController+Navigation.swift
//  ShowcaseApp
//
//  Created by Lukasz Spaczynski on 21/11/2021.
//

extension WelcomeAvatarViewController {
    func navigateNext() {
        navigator.handle(navigation: .next, animated: true)
    }

    func navigatePrev() {
        navigator.handle(navigation: .prev, animated: true)
    }
}
