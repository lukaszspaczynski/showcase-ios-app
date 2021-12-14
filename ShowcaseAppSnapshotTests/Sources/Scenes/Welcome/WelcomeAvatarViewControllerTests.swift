//
//  WelcomeAvatarViewControllerTests.swift
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

final class WelcomeAvatarViewControllerTests: XCTestCase {
    func testErrorView() throws {
        let (sut, _) = Self.prepareTestComponents(.error)

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

    func testWorkingView() throws {
        let (sut, _) = Self.prepareTestComponents(.working)

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

    func testBioView() throws {
        let (sut, _) = Self.prepareTestComponents(.avatar)

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

extension WelcomeAvatarViewControllerTests {
    typealias ViewState = WelcomeAvatarViewModelOutput.ViewState
    typealias Output = WelcomeAvatarViewModelOutput
    typealias OutputFactory = MockedWelcomeAvatarViewModelOutputFactory

    typealias TestComponents = (
        sut: WelcomeAvatarViewController,
        viewModel: WelcomeAvatarViewModel
    )

    static func prepareTestComponents(_ viewState: ViewState) -> TestComponents {
        let viewModel = MockedWelcomeAvatarViewModel {
            OutputFactory.mocked(for: viewState)
        }

        let sut = UIStoryboard(name: "Welcome", bundle: Bundle.main).instantiateViewController(identifier: "WelcomeAvatarViewController") as! WelcomeAvatarViewController
        sut.viewModel = viewModel
        sut.style = DarkAppStyle()
        sut.navigator = MockedNavigator()

        return (sut, viewModel)
    }
}
