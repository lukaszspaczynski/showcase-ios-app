//
//  ConcreteBioWebDataSource.swift
//  ShowcaseData
//
//  Created by Lukasz Spaczynski on 22/11/2021.
//

import Kanna
import RxSwift

public protocol BioWebEndpoint {
    var bioEndpoint: URL { get }
}

public enum HtmlDecoderError: Error {
    case xPathQueryFailed
}

public final class ConcreteBioWebDataSource: BioWebDataSource {
    private let client: RestClient
    private let endpoint: BioWebEndpoint

    public init(client: RestClient, endpoint: BioWebEndpoint) {
        self.client = client
        self.endpoint = endpoint
    }

    public func getBio() -> Observable<Result<Bio, Error>> {
        let client = self.client
        let endpoint = self.endpoint

        let observable = Observable<Result<Bio, Error>>.create { observer in

            let request = BioWebRequest(endpoint: endpoint)
            let task = client.dispatch(request: request) { result in

                let result = result
                    .flatMap(Self.transform)
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

    private static func transform(_ bioResponse: Data) -> Result<HTMLDocument, Error> {
        Result {
            try Kanna.HTML(html: bioResponse, encoding: .utf8)
        }
    }

    private static func transform(_ bioResponse: HTMLDocument) -> Result<Bio, Error> {
        Result {
            guard let bio = Bio(bioResponse) else {
                throw RestClientError
                    .decodeFailure(
                        HtmlDecoderError.xPathQueryFailed)
            }

            return bio
        }
    }
}
