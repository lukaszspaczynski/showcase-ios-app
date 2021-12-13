//
//  ConcreteImageFilterService.swift
//  ShowcaseData
//
//  Created by Lukasz Spaczynski on 02/12/2021.
//

import CoreImage
import RxSwift
import UIKit

public final class ConcreteImageFilterService: ImageFilterService {
    public init() {}

    let context = CIContext()

    public enum FilterServiceError: Error {
        case noImageReference
        case contextImageCreationFailed
        case underlyingError(Error)
    }

    public func applyFilters(_ image: UIImage, _ filters: [ImageFilter]) -> Observable<Result<UIImage, Error>> {
        guard let cgImage = image.cgImage else {
            return .just(.failure(FilterServiceError.noImageReference))
        }

        var ciImage = CIImage(cgImage: cgImage)

        do {
            for filter in filters {
                try Self.applyFilter(filter, to: &ciImage)
            }

            let image = try renderAsUIImage(ciImage)

            return .just(.success(image))

        } catch FilterServiceError.contextImageCreationFailed {
            let error = FilterServiceError.contextImageCreationFailed

            return .just(.failure(error))

        } catch {
            let error = FilterServiceError.underlyingError(error)

            return .just(.failure(error))
        }
    }

    private func renderAsUIImage(_ image: CIImage) throws -> UIImage {
        guard let cgImage = context.createCGImage(image, from: image.extent) else {
            throw FilterServiceError.contextImageCreationFailed
        }

        return UIImage(cgImage: cgImage)
    }

    private static func applyFilter(_ filter: ImageFilter, to image: inout CIImage) throws {
        try filter
            .processor()
            .process(&image)
    }
}
