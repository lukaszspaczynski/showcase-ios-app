//
//  ConcreteBioRepositoryTests.swift
//  ShowcaseDataTests
//
//  Created by Lukasz Spaczynski on 26/11/2021.
//

import Nimble
import RxBlocking
import RxSwift
import ShowcaseDataMocks
import XCTest

@testable import ShowcaseData

class ConcreteBioRepositoryTests: XCTestCase {
    private enum DummyError: Error {
        case dummy
    }

    func testGetBioReturnsValidResult() {
        // GIVEN
        let (sut, dataSource) = Self.prepareTestComponents()

        // WHEN
        dataSource.getBioInvokedResult = .valid
        let bio = try! sut
            .getBio()
            .toBlocking(timeout: 1)
            .first()!

        // THEN
        expect(dataSource.getBioInvoked).to(beTrue())
        expect(bio.hasError).to(beFalse())
        expect(bio.hasValue).to(beTrue())
    }

    func testGetBioReturnsFailureResult() {
        // GIVEN
        let (sut, dataSource) = Self.prepareTestComponents()

        // WHEN
        dataSource.getBioInvokedResult =
            .invalid(error: DummyError.dummy)

        let bio = try! sut
            .getBio()
            .toBlocking(timeout: 1)
            .first()!

        // THEN
        expect(dataSource.getBioInvoked).to(beTrue())
        expect(bio.hasError).to(beTrue())
        expect(bio.hasValue).to(beFalse())
    }
}

extension ConcreteBioRepositoryTests {
    typealias TestComponents = (
        sut: BioRepository,
        dataSource: MockedBioWebDataSource
    )

    static func prepareTestComponents() -> TestComponents {
        let dataSource = MockedBioWebDataSource()

        let sut = ConcreteBioRepository(
            remoteDataSource: dataSource)

        return (sut, dataSource)
    }
}
