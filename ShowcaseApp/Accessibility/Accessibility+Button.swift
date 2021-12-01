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
            enum Page1 {
                static let next = "WelcomePage1ButtonNext"
            }

            enum Page2 {
                static let prev = "WelcomePage2ButtonPrev"
                static let next = "WelcomePage2ButtonNext"
                static let reload = "WelcomePage2ButtonReload"
            }

            enum Page3 {
                static let prev = "WelcomePage3ButtonPrev"
                static let start = "WelcomePage3ButtonStart"
            }
        }
    }
}
