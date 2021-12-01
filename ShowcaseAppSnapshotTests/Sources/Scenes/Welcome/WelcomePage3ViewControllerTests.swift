//
//  WelcomePage3ViewControllerTests.swift
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

class WelcomePage3ViewControllerTests: XCTestCase {
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

extension WelcomePage3ViewControllerTests {
    typealias TestComponents = (
        sut: WelcomePage3ViewController,
        viewModel: WelcomePage3ViewModel
    )

    static func prepareTestComponents() -> TestComponents {
        typealias Output = WelcomePage3ViewModelOutput

        let viewModel = MockedWelcomePage3ViewModel {
            Output(prevDriver: .empty(),
                   startDriver: .empty())
        }

        let sut = UIStoryboard(name: "Welcome", bundle: Bundle.main).instantiateViewController(identifier: "WelcomePage3ViewController") as! WelcomePage3ViewController
        sut.viewModel = viewModel
        sut.style = DarkAppStyle()
        sut.navigator = MockedNavigator()

        return (sut, viewModel)
    }
}
