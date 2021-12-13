//
//  MockedImageFilterService.swift
//  ShowcaseDataMocks
//
//  Created by Lukasz Spaczynski on 13/12/2021.
//

import Kanna
import RxSwift
import ShowcaseData
import UIKit

public class MockedImageFilterService: ImageFilterService {
    public typealias ApplyFilters = Observable<Result<UIImage, Error>>

    public init() {}

    public enum ApplyFiltersResult {
        case valid
        case empty
        case image(UIImage)
        case invalid(error: Error)
    }

    public var applyFiltersInvoked: Bool = false
    public var applyFiltersInvokedResult: ApplyFiltersResult = .empty
    public func applyFilters(_: UIImage, _: [ImageFilter]) -> ApplyFilters {
        applyFiltersInvoked = true

        return Self.resolveApplyFiltersResult(applyFiltersInvokedResult)
    }
}

extension MockedImageFilterService {
    private static func resolveApplyFiltersResult(
        _ type: ApplyFiltersResult) -> ApplyFilters
    {
        switch type {
        case .valid:
            let url = Bundle.current.url(forResource: "mocked-image", withExtension: "jpeg")!
            let imageData = try! Data(contentsOf: url)
            let image = UIImage(data: imageData)!

            return .just(.success(image))
        case .empty:
            return .empty()
        case let .image(image):
            return .just(.success(image))
        case let .invalid(error):
            return .just(.failure(error))
        }
    }
}
