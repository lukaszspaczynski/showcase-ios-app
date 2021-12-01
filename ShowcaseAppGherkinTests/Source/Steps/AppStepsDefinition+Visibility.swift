//
//  AppStepsDefinition+Visibility.swift
//  ShowcaseAppGherkinTests
//
//  Created by Lukasz Spaczynski on 30/11/2021.
//

import Foundation
import KIF
import Nimble
import XCTest_Gherkin

extension AppStepsDefinition {
    enum Visibility: String, MatchedStringRepresentable {
        init?(fromMatch: String) {
            self.init(rawValue: fromMatch)
        }

        case shown
        case hidden
    }

    func defineVisibilitySteps() {
        guard let test = self.test as? GherkinTestCase else {
            return
        }

        step(AppSteps.isShownId) { (id: String, status: Visibility) in

            switch status {
            case .hidden:
                test.tester()
                    .waitForAbsenceOfView(withAccessibilityIdentifier: id)
            case .shown:
                _ = test.tester()
                    .waitForView(withAccessibilityIdentifier: id)
            }
        }

        step(AppSteps.isShownLabel) { (id: String, status: Visibility) in

            switch status {
            case .hidden:
                test.tester()
                    .waitForAbsenceOfView(withAccessibilityLabel: id)
            case .shown:
                _ = test.tester()
                    .waitForView(withAccessibilityLabel: id)
            }
        }
    }
}
