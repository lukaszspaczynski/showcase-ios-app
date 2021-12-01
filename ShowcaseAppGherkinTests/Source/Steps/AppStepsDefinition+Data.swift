//
//  AppStepsDefinition+Data.swift
//  ShowcaseAppGherkinTests
//
//  Created by Lukasz Spaczynski on 30/11/2021.
//

import Foundation
import KIF
import Swinject
import XCTest_Gherkin

extension AppStepsDefinition {
    enum UseCase: String, MatchedStringRepresentable {
        enum Result: String, MatchedStringRepresentable {
            init?(fromMatch: String) {
                self.init(rawValue: fromMatch)
            }

            case success
            case failure
        }

        init?(fromMatch: String) {
            self.init(rawValue: fromMatch)
        }

        case getBio = "GetBio"

        func handle(_ r: Resolver, _ result: Result) {
            switch self {
            case .getBio:
                handleGetBio(r, result)
            }
        }
    }

    func defineDataSteps() {
        guard let test = self.test as? GherkinTestCase else {
            return
        }

        step("(.+) use case returns ((success)|(failure)) result") { (useCase: UseCase, result: UseCase.Result) in

            useCase.handle(test.dependencies, result)
        }
    }
}
