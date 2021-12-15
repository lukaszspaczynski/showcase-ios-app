//
//  ConcreteImageFilterServiceTests.swift
//  ShowcaseDataTests
//
//  Created by Lukasz Spaczynski on 15/12/2021.
//

import Nimble
import RxBlocking
import RxSwift
import SnapshotTesting
import XCTest

@testable import ShowcaseData

final class ConcreteImageFilterServiceTests: XCTestCase {
    func testApplyFilters() throws {
        // GIVEN
        let (sut, image) = Self.prepareTestComponents()

        // WHEN
        let result = try sut
            .applyFilters(
                image,
                [.circle,
                 .pixellate(scale: 10)]
            )
            .toBlocking()
            .first()!

        // THEN
        expect(result.value).toNot(beNil())
        assertSnapshot(matching: UIImageView(image: result.value!), as: .image)
    }
}

extension ConcreteImageFilterServiceTests {
    typealias TestComponents = (
        sut: ConcreteImageFilterService,
        referenceImage: UIImage
    )

    static func prepareTestComponents() -> TestComponents {
        let imageUrl = Bundle.current.url(
            forResource: "reference-image", withExtension: "jpeg"
        )!
        let image = UIImage(
            data: try! Data(contentsOf: imageUrl))!
        let sut = ConcreteImageFilterService()

        return (sut, image)
    }
}
