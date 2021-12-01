//
//  WelcomePage1ViewController+Accessibility.swift
//  ShowcaseApp
//
//  Created by Lukasz Spaczynski on 30/11/2021.
//

import Foundation

extension WelcomePage1ViewController {
    typealias Ids = AccessibilityIdentifiers

    func applyAccessibility() {
        view.accessibilityIdentifier = Ids
            .Screen.Welcome.page1

        buttonNext.accessibilityIdentifier = Ids
            .Button.Welcome.Page1.next
    }
}
