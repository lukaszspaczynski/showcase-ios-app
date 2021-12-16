//
//  WelcomeSkillsViewControllerTests.swift
//  ShowcaseAppSnapshotTests
//
//  Created by Lukasz Spaczynski on 28/11/2021.
//

import Nimble
import RxCocoa
import RxSwift
import ShowcaseData
import ShowcaseDataMocks
import ShowcaseDomain
import ShowcaseDomainMocks
import SnapshotTesting
import XCTest

@testable import ShowcaseApp

final class WelcomeSkillsViewControllerTests: XCTestCase {
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

extension WelcomeSkillsViewControllerTests {
    typealias TestComponents = (
        sut: WelcomeSkillsViewController,
        viewModel: WelcomeSkillsViewModel
    )

    static func prepareTestComponents() -> TestComponents {
        typealias Output = WelcomeSkillsViewModelOutput

        let viewModel = MockedWelcomeSkillsViewModel {
            Output(prevDriver: .empty(), nextDriver: .empty())
        }

        let sut = UIStoryboard(name: "Welcome", bundle: Bundle.main).instantiateViewController(identifier: "WelcomeSkillsViewController") as! WelcomeSkillsViewController
        sut.viewModel = viewModel
        sut.style = DarkAppStyle()
        sut.navigator = MockedNavigator()

        return (sut, viewModel)
    }
}
