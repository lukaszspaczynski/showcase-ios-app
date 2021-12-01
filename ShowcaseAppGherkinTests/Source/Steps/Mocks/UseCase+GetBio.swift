//
//  UseCase+GetBio.swift
//  ShowcaseAppGherkinTests
//
//  Created by Lukasz Spaczynski on 30/11/2021.
//

import Foundation
import ShowcaseDomain
import ShowcaseDomainMocks
import Swinject
import SwinjectAutoregistration

extension AppStepsDefinition.UseCase {
    enum DummyError: Error {
        case dummyError
    }

    func handleGetBio(_ r: Resolver, _ result: Result) {
        let useCase: MockedGetBioUseCase = r.resolve(GetBioUseCase.self) as! MockedGetBioUseCase

        switch result {
        case .success:
            useCase.executeInvokedResult = .callback
            useCase.executeInvokedResultCallback = { observer in
                observer.onNext(GetBioUseCaseOutputMockFactory.mock())
                observer.onCompleted()
            }
        case .failure:
            useCase.executeInvokedResult = .callback
            useCase.executeInvokedResultCallback = { observer in
                observer.onError(DummyError.dummyError)
            }
        }
    }
}
