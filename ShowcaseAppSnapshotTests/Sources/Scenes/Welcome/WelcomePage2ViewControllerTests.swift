//
//  WelcomePage2ViewControllerTests.swift
//  ShowcaseAppSnapshotTests
//
//  Created by Lukasz Spaczynski on 27/11/2021.
//

import Nimble
import RxCocoa
import RxSwift
import ShowcaseDataMocks
import ShowcaseDomainMocks
import SnapshotTesting
import XCTest

@testable import ShowcaseApp

class WelcomePage2ViewControllerTests: XCTestCase {
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

extension WelcomePage2ViewControllerTests {
    typealias ViewState = WelcomePage2ViewModelOutput.ViewState
    typealias Bio = WelcomePage2ViewModelOutput.Bio
    typealias BioFactory = MockedWelcomePage2ViewModelOutputFactory.MockedBioFactory

    typealias TestComponents = (
        sut: WelcomePage2ViewController,
        viewModel: WelcomePage2ViewModel
    )

    static func prepareTestComponents(_ viewState: ViewState) -> TestComponents {
        typealias OutputFactory = MockedWelcomePage2ViewModelOutputFactory

        let viewModel = MockedWelcomePage2ViewModel {
            OutputFactory.mocked(for: viewState)
        }

        let sut = UIStoryboard(name: "Welcome", bundle: Bundle.main).instantiateViewController(identifier: "WelcomePage2ViewController") as! WelcomePage2ViewController
        sut.viewModel = viewModel
        sut.style = DarkAppStyle()
        sut.navigator = MockedNavigator()

        return (sut, viewModel)
    }
}
