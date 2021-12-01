//
//  WelcomePage3ViewController+Accessibility.swift
//  ShowcaseApp
//
//  Created by Lukasz Spaczynski on 30/11/2021.
//

import Foundation

extension WelcomePage3ViewController {
    typealias Ids = AccessibilityIdentifiers

    func applyAccessibility() {
        view.accessibilityIdentifier = Ids
            .Screen.Welcome.page3
        buttonStart.accessibilityIdentifier = Ids
            .Button.Welcome.Page3.start
        buttonPrev.accessibilityIdentifier = Ids
            .Button.Welcome.Page3.prev
    }
}
