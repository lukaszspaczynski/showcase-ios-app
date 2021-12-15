//
//  DomainAssembly.swift
//  ShowcaseApp
//
//  Created by Lukasz Spaczynski on 20/11/2021.
//

import ShowcaseDomain
import Swinject
import SwinjectAutoregistration

final class DomainAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(
            GetBioUseCase.self,
            initializer: ConcreteGetBioUseCase.init
        )

        container.autoregister(
            GetAvatarUseCase.self,
            initializer: ConcreteGetAvatarUseCase.init
        )
    }
}
