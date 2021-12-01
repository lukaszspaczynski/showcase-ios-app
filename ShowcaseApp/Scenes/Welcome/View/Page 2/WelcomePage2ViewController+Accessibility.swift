//
//  WelcomePage2ViewController+Accessibility.swift
//  ShowcaseApp
//
//  Created by Lukasz Spaczynski on 30/11/2021.
//

import Foundation

extension WelcomePage2ViewController {
    typealias Ids = AccessibilityIdentifiers

    func applyAccessibility() {
        view.accessibilityIdentifier = Ids
            .Screen.Welcome.page2

        buttonNext.accessibilityIdentifier = Ids
            .Button.Welcome.Page2.next
        buttonPrev.accessibilityIdentifier = Ids
            .Button.Welcome.Page2.prev
        buttonReload.accessibilityIdentifier = Ids
            .Button.Welcome.Page2.reload

        viewBio.accessibilityIdentifier = Ids
            .View.Welcome.Page2.bio
        viewError.accessibilityIdentifier = Ids
            .View.Welcome.Page2.error
        viewLoading.accessibilityIdentifier = Ids
            .View.Welcome.Page2.loading
    }
}
