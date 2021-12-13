//
//  Accessibility+Button.swift
//  ShowcaseApp
//
//  Created by Lukasz Spaczynski on 30/11/2021.
//

import Foundation

extension AccessibilityIdentifiers {
    enum Button {
        enum Welcome {
            enum Skills {
                static let prev = "WelcomeSkillsButtonPrev"
                static let next = "WelcomeSkillsButtonNext"
            }

            enum Bio {
                static let prev = "WelcomeBioButtonPrev"
                static let next = "WelcomeBioButtonNext"
                static let reload = "WelcomeBioButtonReload"
            }

            enum Avatar {
                static let prev = "WelcomeAvatarButtonPrev"
                static let next = "WelcomeAvatarButtonNext"
                static let reload = "WelcomeAvatarButtonReload"
            }
        }
    }
}
