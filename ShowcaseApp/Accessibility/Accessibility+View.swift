//
//  Accessibility+View.swift
//  ShowcaseApp
//
//  Created by Lukasz Spaczynski on 30/11/2021.
//

import Foundation

extension AccessibilityIdentifiers {
    enum View {
        enum Welcome {
            enum Bio {
                static let error = "WelcomeBioErrorView"
                static let bio = "WelcomeBioBioView"
                static let loading = "WelcomeBioLoadingView"
            }

            enum Avatar {
                static let error = "WelcomeAvatarErrorView"
                static let avatar = "WelcomeAvatarBioView"
                static let loading = "WelcomeAvatarLoadingView"
            }
        }
    }
}
