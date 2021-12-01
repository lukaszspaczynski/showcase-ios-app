//
//  GherkinTestCase.swift
//  ShowcaseAppGherkinTests
//
//  Created by Lukasz Spaczynski on 29/11/2021.
//

import Foundation
import KIF
import Swinject
import SwinjectAutoregistration
import XCTest

@testable import ShowcaseApp

class GherkinTestCase: XCTestCase {
    lazy var dependencies: Resolver = { MocksAssemblerFactory.instantiate().resolver }()
    lazy var navigator: Navigator = {
        dependencies~>
    }()

    override func setUp() {
        super.setUp()

        UIView.setAnimationsEnabled(false)
    }
}

extension XCTestCase {
    func tester(file: String = #file, _ line: Int = #line) -> KIFUITestActor {
        KIFUITestActor(inFile: file, atLine: line, delegate: self)
    }

    func system(file: String = #file, _ line: Int = #line) -> KIFSystemTestActor {
        KIFSystemTestActor(inFile: file, atLine: line, delegate: self)
    }
}

extension KIFTestActor {
    func tester(file: String = #file, _ line: Int = #line) -> KIFUITestActor {
        KIFUITestActor(inFile: file, atLine: line, delegate: self)
    }

    func system(file: String = #file, _ line: Int = #line) -> KIFSystemTestActor {
        KIFSystemTestActor(inFile: file, atLine: line, delegate: self)
    }
}
