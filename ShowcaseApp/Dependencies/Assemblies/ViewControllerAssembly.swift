//
//  ViewControllerAssembly.swift
//  ShowcaseApp
//
//  Created by Lukasz Spaczynski on 20/11/2021.
//

import Swinject
import SwinjectAutoregistration
import SwinjectStoryboard

final class ViewControllerAssembly: Assembly {
    func assemble(container: Container) {
        container.register(Navigator.self) {
            ConcreteNavigator(dependencies: $0)
        }

        container.autoregister(
            AppStyle.self,
            initializer: DarkAppStyle.init
        )

        assembleWelcome(container: container)
    }
}
