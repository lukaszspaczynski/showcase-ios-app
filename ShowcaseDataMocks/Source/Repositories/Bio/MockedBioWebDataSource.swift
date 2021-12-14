//
//  MockedBioWebDataSource.swift
//  ShowcaseDataMocks
//
//  Created by Lukasz Spaczynski on 26/11/2021.
//

import Kanna
import RxSwift
import ShowcaseData

public final class MockedBioWebDataSource: BioWebDataSource {
    public init() {}

    public enum GetTemplateResult {
        case valid
        case empty
        case bio(Bio)
        case invalid(error: Error)
    }

    public var getBioInvoked: Bool = false
    public var getBioInvokedResult: GetTemplateResult = .empty
    public func getBio() -> Observable<Result<Bio, Error>> {
        getBioInvoked = true

        return Self.resolveGetBioResult(getBioInvokedResult)
    }
}

extension MockedBioWebDataSource {
    private static func resolveGetBioResult(
        _ type: GetTemplateResult) -> Observable<Result<Bio, Error>>
    {
        switch type {
        case .valid:

            let data = try! HTMLRepository
                .bioResponseValid
                .data()

            let html = try! Kanna
                .HTML(html: data, encoding: .utf8)

            let result = Bio(html)!

            return .just(.success(result))
        case .empty:
            return .empty()
        case let .bio(bio):
            return .just(.success(bio))
        case let .invalid(error):
            return .just(.failure(error))
        }
    }
}
