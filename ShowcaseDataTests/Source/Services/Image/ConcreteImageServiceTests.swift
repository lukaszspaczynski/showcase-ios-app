//
//  ConcreteImageServiceTests.swift
//  ShowcaseDataTests
//
//  Created by Lukasz Spaczynski on 15/12/2021.
//

import Nimble
import RxBlocking
import RxSwift
import ShowcaseDataMocks
import XCTest

@testable import ShowcaseData

final class ConcreteImageServiceTests: XCTestCase {
    private enum DummyError: Error {
        case dummy
    }

    func testGetRemoteImageReturnsValidResult() throws {
        // GIVEN
        let (sut, client, url, data) = Self.prepareTestComponents()
        client.dispatchInvokedResult = .success(data)

        // WHEN
        let result = try sut
            .getRemoteImage(url)
            .toBlocking()
            .first()!

        // THEN
        expect(client.dispatchInvoked).to(beTrue())
        expect(result.hasError).to(beFalse())
        expect(result.hasValue).to(beTrue())
    }

    func testGetRemoteImageReturnsFailure() throws {
        // GIVEN
        let (sut, client, url, _) = Self.prepareTestComponents()
        client.dispatchInvokedResult = .failure(DummyError.dummy)

        // WHEN
        let result = try sut
            .getRemoteImage(url)
            .toBlocking()
            .first()!

        // THEN
        expect(client.dispatchInvoked).to(beTrue())
        expect(result.hasError).to(beTrue())
        expect(result.hasValue).to(beFalse())
    }
}

extension ConcreteImageServiceTests {
    typealias TestComponents = (
        sut: ConcreteImageService,
        client: MockedRestClient,
        url: URL,
        data: Data
    )

    static func prepareTestComponents() -> TestComponents {
        let client = MockedRestClient()
        let sut = ConcreteImageService(client: client)
        let url = URL(string: "http://dummy.net")!
        let imageUrl = Bundle.current.url(
            forResource: "reference-image", withExtension: "jpeg"
        )!
        let data = try! Data(contentsOf: imageUrl)

        return (sut, client, url, data)
    }
}
