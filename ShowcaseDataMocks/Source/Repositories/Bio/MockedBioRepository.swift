//
//  MockedBioRepository.swift
//  ShowcaseDataMocks
//
//  Created by Lukasz Spaczynski on 25/11/2021.
//

import Kanna
import RxSwift
import ShowcaseData

public class MockedBioRepository: BioRepository {
    public init() {}

    public enum GetBioResult {
        case valid
        case empty
        case bio(Bio)
        case invalid(error: Error)
    }

    public var getBioInvoked: Bool = false
    public var getBioInvokedResult: GetBioResult = .empty
    public func getBio() -> Observable<Result<Bio, Error>> {
        getBioInvoked = true
        return Self.resolveGetBioResult(getBioInvokedResult)
    }
}

extension MockedBioRepository {
    private static func resolveGetBioResult(
        _ type: GetBioResult) ->
        Observable<Result<Bio, Error>>
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
        case let .bio(bio):
            return .just(.success(bio))
        case .empty:
            return .empty()
        case let .invalid(error):
            return .just(.failure(error))
        }
    }
}
