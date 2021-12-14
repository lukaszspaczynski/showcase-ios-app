//
//  ConcreteBioWebDataSourceTests.swift
//  ShowcaseDataTests
//
//  Created by Lukasz Spaczynski on 22/11/2021.
//

import Nimble
import RxBlocking
import RxSwift
import ShowcaseDataMocks
import XCTest

@testable import ShowcaseData

final class ConcreteBioWebDataSourceTests: XCTestCase {
    private enum DummyError: Error {
        case dummy
    }

    func testGetBioReturnsValidResult() {
        // GIVEN
        let (sut, restClient, _, bioResponse) = Self.prepareTestComponents()
        restClient.dispatchInvokedResult = .success(bioResponse)

        // WHEN
        let result = try! sut
            .getBio()
            .toBlocking(timeout: 1)
            .first()!

        // THEN
        expect(restClient.dispatchInvoked).to(beTrue())
        expect(result.hasValue).to(beTrue())
        expect(result.hasError).to(beFalse())
        expect(result.value!.bios.count).to(equal(2))
        expect(result.value!.links.count).to(equal(2))
        expect(result.value!.location.count).to(beGreaterThan(3))
        expect(result.value!.name.count).to(beGreaterThan(3))
        expect(result.value!.role.count).to(beGreaterThan(3))
    }

    func testGetBioReturnsFailure() {
        // GIVEN
        let (sut, restClient, _, _) = Self.prepareTestComponents()
        restClient.dispatchInvokedResult = .failure(DummyError.dummy)

        // WHEN
        let result = try! sut
            .getBio()
            .toBlocking(timeout: 1)
            .first()!

        // THEN
        expect(restClient.dispatchInvoked).to(beTrue())
        expect(result.hasError).to(beTrue())
        expect(result.hasValue).to(beFalse())
    }
}

extension ConcreteBioWebDataSourceTests {
    typealias TestComponents = (
        sut: BioWebDataSource,
        restClient: MockedRestClient,
        endpoint: MockedEndpoints,
        bioResponse: Data
    )

    static func prepareTestComponents() -> TestComponents {
        let restClient = MockedRestClient()
        let endpoint = MockedEndpoints()
        let bioResponse: Data = try! HTMLRepository
            .bioResponseValid
            .data()
        let sut = ConcreteBioWebDataSource(
            client: restClient,
            endpoint: endpoint
        )

        return (sut, restClient, endpoint, bioResponse)
    }
}
