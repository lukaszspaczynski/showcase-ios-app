//
//  AppStepsDefinition+Screen.swift
//  ShowcaseAppGherkinTests
//
//  Created by Lukasz Spaczynski on 30/11/2021.
//

import Foundation
import KIF
import Nimble
import XCTest_Gherkin

@testable import ShowcaseApp

extension AppStepsDefinition {
    enum Screen: String, MatchedStringRepresentable {
        init?(fromMatch: String) {
            self.init(rawValue: fromMatch)
        }

        case welcome = "Welcome"
        case welcomePage1 = "WelcomePage1"
        case welcomePage2 = "WelcomePage2"
        case welcomePage3 = "WelcomePage3"
    }

    func defineScreenSteps() {
        guard let test = self.test as? GherkinTestCase else {
            return
        }

        step(Step.enterScreen) { (screen: Screen) in
            test.navigator
                .handle(
                    navigation: .root(Navigation.Screen.from(screen)),
                    animated: false
                )
        }

        step(AppSteps.onPage) { (id: String, accessibility: AccessibilityType) in

            switch accessibility {
            case .id:
                let view = test.tester()
                    .waitForView(withAccessibilityIdentifier: id)
                expect(view).notTo(beNil())
            case .label:
                let view = test.tester()
                    .waitForView(withAccessibilityLabel: id)
                expect(view).notTo(beNil())
            }
        }
    }
}

extension Navigation.Screen {
    static func from(_ stepScreen: AppStepsDefinition.Screen) -> Self {
        switch stepScreen {
        case .welcome:
            return Self.welcome()
        case .welcomePage1:
            return Self.welcome([.first, .second, .third])
        case .welcomePage2:
            return Self.welcome([.second, .third, .first])
        case .welcomePage3:
            return Self.welcome([.third, .first, .second])
        }
    }
}
