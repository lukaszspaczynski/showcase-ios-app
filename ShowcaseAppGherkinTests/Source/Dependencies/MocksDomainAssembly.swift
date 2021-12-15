//
//  MocksDomainAssembly.swift
//  ShowcaseAppGherkinTests
//
//  Created by Lukasz Spaczynski on 30/11/2021.
//

import ShowcaseDomain
import ShowcaseDomainMocks
import Swinject
import SwinjectAutoregistration

@testable import ShowcaseApp

final class MocksDomainAssembly: Assembly {
    func assemble(container: Container) {
        container.register(AvatarEndpoint.self) {
            _ in Endpoints.shared
        }

        container.autoregister(
            GetBioUseCase.self,
            initializer: MockedGetBioUseCase.init
        )

        container.autoregister(
            GetAvatarUseCase.self,
            initializer: MockedGetAvatarUseCase.init
        )
    }
}
