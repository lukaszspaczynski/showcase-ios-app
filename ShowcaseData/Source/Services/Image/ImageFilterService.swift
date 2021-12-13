//
//  ImageFilterService.swift
//  ShowcaseData
//
//  Created by Lukasz Spaczynski on 02/12/2021.
//

import RxSwift
import UIKit

public enum ImageFilter {
    case pixellate(scale: Int)
    case circle
    case custom(ImageFilterProcessor)

    internal func processor() -> ImageFilterProcessor {
        switch self {
        case let .pixellate(scale):
            return PixellateProcessor(scale: scale)
        case .circle:
            return CircleProcessor()
        case let .custom(processor):
            return processor
        }
    }
}

public protocol ImageFilterService {
    func applyFilters(_ image: UIImage, _ filters: [ImageFilter]) -> Observable<Result<UIImage, Error>>
}
