//
//  BioTests.swift
//  ShowcaseDataTests
//
//  Created by Lukasz Spaczynski on 26/11/2021.
//

import Kanna
import Nimble
import ShowcaseDataMocks
import XCTest

@testable import ShowcaseData

final class BioTests: XCTestCase {
    func testInstantiateWithHtml() {
        let (sut, _) = Self.prepareTestComponents()

        expect(sut.bios.count).to(equal(2))
        expect(sut.links.count).to(equal(2))
        expect(sut.location).to(equal("Katowice, Poland"))
        expect(sut.name).to(equal("Łukasz Spaczyński"))
        expect(sut.role).to(equal("Software Engineer"))
        expect(sut.bios[0].count).to(equal(279))
        expect(sut.bios[1].count).to(equal(144))
        expect(sut.links[0].title).to(equal("Visit me on LinkedIn"))
        expect(sut.links[0].url.absoluteString).to(equal("http://www.linkedin.com/pub/%C5%82ukasz-spaczy%C5%84ski/5a/431/78a"))
        expect(sut.links[1].title).to(equal("Visit me on GitHub"))
        expect(sut.links[1].url.absoluteString).to(equal("https://github.com/lspaczynski"))
    }
}

extension BioTests {
    typealias TestComponents = (
        sut: Bio,
        document: HTMLDocument
    )

    static func prepareTestComponents() -> TestComponents {
        let data = try! HTMLRepository
            .bioResponseValid
            .data()
        let html = try! Kanna
            .HTML(html: data, encoding: .utf8)

        let sut = Bio(html)!

        return (sut, html)
    }
}
