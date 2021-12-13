//
//  WelcomeSkillsViewController+Accessibility.swift
//  ShowcaseApp
//
//  Created by Lukasz Spaczynski on 30/11/2021.
//

import Foundation

extension WelcomeSkillsViewController {
    typealias Ids = AccessibilityIdentifiers

    func applyAccessibility() {
        view.accessibilityIdentifier = Ids
            .Screen.Welcome.skills

        buttonNext.accessibilityIdentifier = Ids
            .Button.Welcome.Skills.next
        buttonPrev.accessibilityIdentifier = Ids
            .Button.Welcome.Skills.prev
    }
}
