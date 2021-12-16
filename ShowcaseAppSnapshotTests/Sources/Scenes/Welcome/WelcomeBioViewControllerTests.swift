//
//  WelcomeBioViewControllerTests.swift
//  ShowcaseAppSnapshotTests
//
//  Created by Lukasz Spaczynski on 27/11/2021.
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

final class WelcomeBioViewControllerTests: XCTestCase {
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
        let (sut, _) = Self.prepareTestComponents(.bio)

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

extension WelcomeBioViewControllerTests {
    typealias ViewState = WelcomeBioViewModelOutput.ViewState
    typealias Bio = WelcomeBioViewModelOutput.Bio
    typealias OutputFactory = MockedWelcomeBioViewModelOutputFactory

    typealias TestComponents = (
        sut: WelcomeBioViewController,
        viewModel: WelcomeBioViewModel
    )

    static func prepareTestComponents(_ viewState: ViewState) -> TestComponents {
        let viewModel = MockedWelcomeBioViewModel {
            OutputFactory.mocked(for: viewState)
        }

        let sut = UIStoryboard(name: "Welcome", bundle: Bundle.main).instantiateViewController(identifier: "WelcomeBioViewController") as! WelcomeBioViewController
        sut.viewModel = viewModel
        sut.style = DarkAppStyle()
        sut.navigator = MockedNavigator()

        return (sut, viewModel)
    }
}
