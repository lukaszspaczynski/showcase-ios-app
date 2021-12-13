//
//  CircleProcessor.swift
//  ShowcaseData
//
//  Created by Lukasz Spaczynski on 13/12/2021.
//
//

import CoreImage

final class CircleProcessor: ImageFilterProcessor {
    typealias Error = ImageFilterProcessorError

    func process(_ image: inout CIImage) throws {
        let center = CIVector(
            x: image.extent.width / 2.0,
            y: image.extent.height / 2.0
        )

        let radius = min(
            image.extent.width,
            image.extent.height
        ) / 2.0

        let radialFilterName = "CIRadialGradient"
        let color0 = CIColor(red: 1, green: 1, blue: 1, alpha: 1)
        let color1 = CIColor(red: 0, green: 0, blue: 0, alpha: 0)
        guard let circle = CIFilter(
            name: radialFilterName,
            parameters: [
                "inputRadius0": radius,
                "inputRadius1": radius,
                "inputColor0": color0,
                "inputColor1": color1,
                kCIInputCenterKey: center,
            ]
        )?.outputImage else {
            throw Error.filterFailure(radialFilterName)
        }

        let maskFilterName = "CIMaskToAlpha"
        guard let mask = CIFilter(
            name: maskFilterName,
            parameters: [
                kCIInputImageKey: circle,
            ]
        )?.outputImage else {
            throw Error.filterFailure(maskFilterName)
        }

        let blendFilterName = "CIBlendWithAlphaMask"
        guard let combine = CIFilter(
            name: blendFilterName,
            parameters: [
                kCIInputMaskImageKey: mask,
                kCIInputImageKey: image,
            ]
        )?.outputImage else {
            throw Error.filterFailure(blendFilterName)
        }

        image = combine
    }
}
