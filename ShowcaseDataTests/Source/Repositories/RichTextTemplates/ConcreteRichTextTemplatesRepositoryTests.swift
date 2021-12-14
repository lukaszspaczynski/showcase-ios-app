//
//  ConcreteRichTextTemplatesRepositoryTests.swift
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

final class ConcreteRichTextTemplatesRepositoryTests: XCTestCase {
    private enum DummyError: Error {
        case dummy
    }

    func testGetTempleteReturnsValidResult() {
        // GIVEN
        let (sut, dataSource) = Self.prepareTestComponents()

        // WHEN
        let name = MockedRichTextTemplateNames.dummy
        dataSource.getTemplateInvokedResult = .name(name: name)

        let template = try! sut
            .getTemplate(name)
            .toBlocking(timeout: 1)
            .first()!

        // THEN
        expect(dataSource.getTemplateInvoked).to(beTrue())
        expect(template.hasError).to(beFalse())
        expect(template.hasValue).to(beTrue())
    }

    func testGetTempleteReturnsFailureResult() {
        // GIVEN
        let (sut, dataSource) = Self.prepareTestComponents()

        // WHEN
        let name = MockedRichTextTemplateNames.notExisting

        dataSource.getTemplateInvokedResult =
            .invalid(error: DummyError.dummy)

        let template = try! sut
            .getTemplate(name)
            .toBlocking(timeout: 1)
            .first()!

        // THEN
        expect(dataSource.getTemplateInvoked).to(beTrue())
        expect(template.hasError).to(beTrue())
        expect(template.hasValue).to(beFalse())
    }
}

extension ConcreteRichTextTemplatesRepositoryTests {
    typealias TestComponents = (
        sut: RichTextTemplatesRepository,
        dataSource: MockedRichTextTemplatesLocalDataSource
    )

    static func prepareTestComponents() -> TestComponents {
        let dataSource = MockedRichTextTemplatesLocalDataSource()

        let sut = ConcreteRichTextTemplatesRepository(
            localDataSource: dataSource)

        return (sut, dataSource)
    }
}
