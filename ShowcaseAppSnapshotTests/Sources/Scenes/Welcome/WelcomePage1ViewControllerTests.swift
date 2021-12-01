//
//  WelcomePage1ViewControllerTests.swift
//  ShowcaseAppSnapshotTests
//
//  Created by Lukasz Spaczynski on 28/11/2021.
//

import Nimble
import RxCocoa
import RxSwift
import ShowcaseDataMocks
import ShowcaseDomainMocks
import SnapshotTesting
import XCTest

@testable import ShowcaseApp

class WelcomePage1ViewControllerTests: XCTestCase {
    func testView() throws {
        let (sut, _) = Self.prepareTestComponents()

        let result = Self.testingDevices
            .compactMap {
                verifySnapshot(
                    matching: sut,
                    as: .image(on: $0.value),
                    named: "\(#function)-\($0.key)"
                )
            }
        expect(result.count).to(equal(0))
    }
}

extension WelcomePage1ViewControllerTests {
    typealias TestComponents = (
        sut: WelcomePage1ViewController,
        viewModel: WelcomePage1ViewModel
    )

    static func prepareTestComponents() -> TestComponents {
        typealias Output = WelcomePage1ViewModelOutput

        let viewModel = MockedWelcomePage1ViewModel {
            Output(nextDriver: .empty())
        }

        let sut = UIStoryboard(name: "Welcome", bundle: Bundle.main).instantiateViewController(identifier: "WelcomePage1ViewController") as! WelcomePage1ViewController
        sut.viewModel = viewModel
        sut.style = DarkAppStyle()
        sut.navigator = MockedNavigator()

        return (sut, viewModel)
    }
}
