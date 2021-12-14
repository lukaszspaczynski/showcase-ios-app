//
//  BioWebRequestTests.swift
//  ShowcaseDataTests
//
//  Created by Lukasz Spaczynski on 25/11/2021.
//

import Nimble
import ShowcaseDataMocks
import XCTest

@testable import ShowcaseData

final class BioWebRequestTests: XCTestCase {
    func testInstantiateRequest() {
        let (sut, endpoint) = Self.prepareTestComponents()

        expect(sut.url).to(be(endpoint.bioEndpoint))
        expect(sut.method).to(equal(RestRequestMethod.get))
    }
}

extension BioWebRequestTests {
    typealias TestComponents = (
        sut: BioWebRequest,
        endpoint: MockedEndpoints
    )

    static func prepareTestComponents() -> TestComponents {
        let endpoint = MockedEndpoints()
        let sut = BioWebRequest(endpoint: endpoint)

        return (sut, endpoint)
    }
}
