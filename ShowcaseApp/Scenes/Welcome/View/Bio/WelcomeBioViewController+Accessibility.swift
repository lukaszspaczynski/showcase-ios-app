//
//  WelcomeBioViewController+Accessibility.swift
//  ShowcaseApp
//
//  Created by Lukasz Spaczynski on 30/11/2021.
//

import Foundation

extension WelcomeBioViewController {
    typealias Ids = AccessibilityIdentifiers

    func applyAccessibility() {
        view.accessibilityIdentifier = Ids
            .Screen.Welcome.bio

        buttonNext.accessibilityIdentifier = Ids
            .Button.Welcome.Bio.next
        buttonPrev.accessibilityIdentifier = Ids
            .Button.Welcome.Bio.prev
        buttonReload.accessibilityIdentifier = Ids
            .Button.Welcome.Bio.reload

        viewBio.accessibilityIdentifier = Ids
            .View.Welcome.Bio.bio
        viewError.accessibilityIdentifier = Ids
            .View.Welcome.Bio.error
        viewLoading.accessibilityIdentifier = Ids
            .View.Welcome.Bio.loading
    }
}
