//
//  ConcreteRichTextTemplatesLocalDataSourceTests.swift
//  ShowcaseDataTests
//
//  Created by Lukasz Spaczynski on 25/11/2021.
//

import Nimble
import RxBlocking
import RxSwift
import ShowcaseDataMocks
import XCTest

@testable import ShowcaseData

final class ConcreteRichTextTemplatesLocalDataSourceTests: XCTestCase {
    func testGettingAllTemplates() {
        // GIVEN
        let sut = ConcreteRichTextTemplatesLocalDataSource()

        // THEN
        for name in RichTextTemplateName.allCases {
            let template = try! sut
                .getTemplate(name)
                .toBlocking(timeout: 1)
                .first()!

            expect(template.hasError).to(beFalse())
            expect(template.hasValue).to(beTrue())
            expect(template.value!.name.description).to(be(name.description))
            expect(template.value!.value.length).to(beGreaterThan(0))
        }
    }

    func testGetTemplateFailureResult() {
        // GIVEN
        let sut = ConcreteRichTextTemplatesLocalDataSource()

        // WHEN
        let name = MockedRichTextTemplateNames.notExisting
        let template = try! sut
            .getTemplate(name)
            .toBlocking(timeout: 1)
            .first()!

        // THEN
        expect(template.hasError).to(beTrue())
    }
}
