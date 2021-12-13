//
//  ShowcaseAppGherkinTests.swift
//  ShowcaseAppGherkinTests
//
//  Created by Lukasz Spaczynski on 29/11/2021.
//

import XCTest
import XCTest_Gherkin

@testable import ShowcaseApp

class ShowcaseAppGherkinTests: GherkinTestCase {
    func testSwitchingPagesForward() throws {
        NativeRunner.runScenario(
            featureFile: "WelcomePage.feature",
            scenario: "Switching pages forward",
            testCase: self
        )
    }

    func testSwitchingPagesBackward() throws {
        NativeRunner.runScenario(
            featureFile: "WelcomePage.feature",
            scenario: "Switching pages backward",
            testCase: self
        )
    }

    func testLoopingBackwardPages() throws {
        NativeRunner.runScenario(
            featureFile: "WelcomePage.feature",
            scenario: "Looping pages backward",
            testCase: self
        )
    }

    func testLoopingForwardPages() throws {
        NativeRunner.runScenario(
            featureFile: "WelcomePage.feature",
            scenario: "Looping pages forward",
            testCase: self
        )
    }

    func testReloadingBio() throws {
        NativeRunner.runScenario(
            featureFile: "WelcomePage.feature",
            scenario: "Reloading Bio",
            testCase: self
        )
    }

    func testReloadingAvatar() throws {
        NativeRunner.runScenario(
            featureFile: "WelcomePage.feature",
            scenario: "Reloading Avatar",
            testCase: self
        )
    }
}
