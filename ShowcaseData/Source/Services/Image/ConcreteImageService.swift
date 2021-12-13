//
//  ConcreteImageService.swift
//  ShowcaseData
//
//  Created by Lukasz Spaczynski on 01/12/2021.
//

import RxSwift
import UIKit

public final class ConcreteImageService: ImageService {
    public enum ImageServiceError: Error {
        case cantCreateImageFromData
        case underlyingError(Error)
    }

    private let client: RestClient

    public init(client: RestClient) {
        self.client = client
    }

    public func getRemoteImage(_ url: URL) -> Observable<Result<UIImage, Error>> {
        let client = self.client

        let observable = Observable<Result<UIImage, Error>>.create { observer in

            let request = ImageRequest(url: url)

            let task = client.dispatch(request: request) { result in

                let result = result
                    .mapError { ImageServiceError.underlyingError($0) }
                    .flatMap(Self.transform)

                observer.onNext(result)
                observer.onCompleted()
            }

            task.resume()

            return Disposables.create {
                task.cancel()
            }
        }

        return observable
    }

    private static func transform(_ imageData: Data) -> Result<UIImage, Error> {
        Result {
            guard let image = UIImage(data: imageData) else {
                throw ImageServiceError.cantCreateImageFromData
            }

            return image
        }
    }
}
