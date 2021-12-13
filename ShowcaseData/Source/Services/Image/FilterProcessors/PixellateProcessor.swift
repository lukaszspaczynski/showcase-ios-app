//
//  PixellateProcessor.swift
//  ShowcaseData
//
//  Created by Lukasz Spaczynski on 02/12/2021.
//

import CoreImage

final class PixellateProcessor: ImageFilterProcessor {
    typealias Error = ImageFilterProcessorError

    let scale: Int

    init(scale: Int) {
        self.scale = scale
    }

    func process(_ image: inout CIImage) throws {
        let filterName = "CIPixellate"

        let center = CIVector(
            x: image.extent.width / 2.0,
            y: image.extent.height / 2.0
        )

        guard let output = CIFilter(
            name: filterName,
            parameters: [
                kCIInputImageKey: image,
                kCIInputScaleKey: scale,
                kCIInputCenterKey: center,
            ]
        )?.outputImage else {
            throw Error.filterFailure(filterName)
        }

        image = output
    }
}
