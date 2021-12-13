//
//  MockedImageService.swift
//  ShowcaseDataMocks
//
//  Created by Lukasz Spaczynski on 13/12/2021.
//

import Kanna
import RxSwift
import ShowcaseData
import UIKit

public class MockedImageService: ImageService {
    public typealias GetRemoteImage = Observable<Result<UIImage, Error>>

    public init() {}

    public enum GetRemoteImageResult {
        case valid
        case empty
        case image(UIImage)
        case invalid(error: Error)
    }

    public var getRemoteImageInvoked: Bool = false
    public var getRemoteImageInvokedResult: GetRemoteImageResult = .empty
    public func getRemoteImage(_: URL) -> GetRemoteImage {
        getRemoteImageInvoked = true

        return Self.resolveGetRemoteImageResult(getRemoteImageInvokedResult)
    }
}

extension MockedImageService {
    private static func resolveGetRemoteImageResult(
        _ type: GetRemoteImageResult) -> GetRemoteImage
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
