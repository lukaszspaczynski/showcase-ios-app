//
//  PixellateProcessorTests.swift
//  ShowcaseDataTests
//
//  Created by Lukasz Spaczynski on 15/12/2021.
//

import CoreImage
import Nimble
import SnapshotTesting
import XCTest

@testable import ShowcaseData

final class PixellateProcessorTests: XCTestCase {
    func testProcessImage() throws {
        // GIVEN
        var (sut, image, context) = Self.prepareTestComponents(scale: 10)

        // WHEN
        try sut.process(&image)
        let cgImage = context.createCGImage(image, from: image.extent)!
        let uiImage = UIImage(cgImage: cgImage)
        let imageView = UIImageView(image: uiImage)

        // THEN
        assertSnapshot(matching: imageView, as: .image)
    }
}

extension PixellateProcessorTests {
    typealias TestComponents = (
        sut: PixellateProcessor,
        referenceImage: CIImage,
        context: CIContext
    )

    static func prepareTestComponents(scale: Int) -> TestComponents {
        let context = CIContext()
        let imageUrl = Bundle.current.url(
            forResource: "reference-image", withExtension: "jpeg"
        )!
        let image = UIImage(
            data: try! Data(contentsOf: imageUrl))!
        let ciimage = CIImage(cgImage: image.cgImage!)
        let sut = PixellateProcessor(scale: scale)

        return (sut, ciimage, context)
    }
}
