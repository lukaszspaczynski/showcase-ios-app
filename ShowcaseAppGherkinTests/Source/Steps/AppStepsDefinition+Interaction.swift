//
//  AppStepsDefinition+Interaction.swift
//  ShowcaseAppGherkinTests
//
//  Created by Lukasz Spaczynski on 30/11/2021.
//

import Foundation
import KIF
import XCTest_Gherkin

extension AppStepsDefinition {
    enum SwipeDirection: String, MatchedStringRepresentable {
        init?(fromMatch: String) {
            self.init(rawValue: fromMatch)
        }

        case left
        case right
        case up
        case down
    }

    func defineInteractionSteps() {
        guard let test = self.test as? GherkinTestCase else {
            return
        }

        step(Step.tapsElement) { (id: String, accessibility: AccessibilityType) in

            switch accessibility {
            case .id:
                test.tester()
                    .tapView(withAccessibilityIdentifier: id)
            case .label:
                test.tester()
                    .tapView(withAccessibilityLabel: id)
            }
        }

        step(Step.swipesId) { (direction: SwipeDirection, id: String) in

            test.tester()
                .swipeView(withAccessibilityIdentifier: id, in: KIFSwipeDirection(direction))
        }

        step(Step.swipesLabel) { (direction: SwipeDirection, id: String) in

            test.tester()
                .swipeView(withAccessibilityLabel: id, in: KIFSwipeDirection(direction))
        }
    }
}

extension KIFSwipeDirection {
    init(_ direction: AppStepsDefinition.SwipeDirection) {
        switch direction {
        case .down:
            self = .down
        case .left:
            self = .left
        case .right:
            self = .right
        case .up:
            self = .up
        }
    }
}
