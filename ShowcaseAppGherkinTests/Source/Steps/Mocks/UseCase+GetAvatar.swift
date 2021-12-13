//
//  UseCase+GetAvatar.swift
//  ShowcaseAppGherkinTests
//
//  Created by Lukasz Spaczynski on 06/12/2021.
//

import Foundation
import ShowcaseDomain
import ShowcaseDomainMocks
import Swinject
import SwinjectAutoregistration

extension AppStepsDefinition.UseCase {
    private typealias Error = AppStepsDefinition.DummyError

    func handleGetAvatar(_ r: Resolver, _ result: Result) {
        let useCase: MockedGetAvatarUseCase = r.resolve(GetAvatarUseCase.self) as! MockedGetAvatarUseCase

        switch result {
        case .success:
            useCase.executeInvokedResult = .callback
            useCase.executeInvokedResultCallback = { observer in
                observer.onNext(GetAvatarUseCaseOutputMockFactory.mock())
                observer.onCompleted()
            }
        case .failure:
            useCase.executeInvokedResult = .callback
            useCase.executeInvokedResultCallback = { observer in
                observer.onError(Error.dummyError)
            }
        }
    }
}
