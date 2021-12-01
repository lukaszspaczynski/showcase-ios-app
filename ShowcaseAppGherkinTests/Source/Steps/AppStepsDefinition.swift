//
//  AppStepsDefinition.swift
//  ShowcaseAppGherkinTests
//
//  Created by Lukasz Spaczynski on 29/11/2021.
//

import Foundation
import KIF
import Nimble
import XCTest_Gherkin

@testable import ShowcaseApp

final class AppStepsDefinition: StepDefiner {
    typealias Step = AppSteps

    enum AccessibilityType: String, MatchedStringRepresentable {
        init?(fromMatch: String) {
            self.init(rawValue: fromMatch)
        }

        case id
        case label
    }

    override func defineSteps() {
        super.defineSteps()

        step(Step.startApp) {
            print("User starts the app")
        }

        defineScreenSteps()
        defineInteractionSteps()
        defineDataSteps()
        defineVisibilitySteps()
    }
}
