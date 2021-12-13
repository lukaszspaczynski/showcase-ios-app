//
//  WelcomeSkillsViewController+Navigation.swift
//  ShowcaseApp
//
//  Created by Lukasz Spaczynski on 21/11/2021.
//

extension WelcomeSkillsViewController {
    func navigatePrev() {
        navigator.handle(navigation: .prev, animated: true)
    }

    func navigateNext() {
        navigator.handle(navigation: .next, animated: true)
    }
}
