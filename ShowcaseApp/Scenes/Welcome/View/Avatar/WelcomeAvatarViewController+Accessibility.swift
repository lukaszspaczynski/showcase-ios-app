//
//  WelcomeAvatarViewController+Accessibility.swift
//  ShowcaseApp
//
//  Created by Lukasz Spaczynski on 30/11/2021.
//

import Foundation

extension WelcomeAvatarViewController {
    typealias Ids = AccessibilityIdentifiers

    func applyAccessibility() {
        view.accessibilityIdentifier = Ids
            .Screen.Welcome.avatar

        buttonNext.accessibilityIdentifier = Ids
            .Button.Welcome.Avatar.next
        buttonPrev.accessibilityIdentifier = Ids
            .Button.Welcome.Avatar.prev
        buttonReload.accessibilityIdentifier = Ids
            .Button.Welcome.Avatar.reload

        viewAvatar.accessibilityIdentifier = Ids
            .View.Welcome.Avatar.avatar
        viewError.accessibilityIdentifier = Ids
            .View.Welcome.Avatar.error
        viewLoading.accessibilityIdentifier = Ids
            .View.Welcome.Avatar.loading
    }
}
