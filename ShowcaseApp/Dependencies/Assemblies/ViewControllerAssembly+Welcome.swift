//
//  ViewControllerAssembly+Welcome.swift
//  ShowcaseApp
//
//  Created by Lukasz Spaczynski on 21/11/2021.
//

import Swinject
import SwinjectAutoregistration
import SwinjectStoryboard

extension ViewControllerAssembly {
    func assembleWelcome(container: Container) {
        container.autoregister(
            WelcomeViewModel.self,
            initializer: ConcreteWelcomeViewModel.init
        )

        container.autoregister(
            WelcomeSkillsViewModel.self,
            initializer: ConcreteWelcomeSkillsViewModel.init
        )

        container.autoregister(
            WelcomeBioViewModel.self,
            initializer: ConcreteWelcomeBioViewModel.init
        )

        container.autoregister(
            WelcomeAvatarViewModel.self,
            initializer: ConcreteWelcomeAvatarViewModel.init
        )

        container.register(WelcomeViewController.self) {
            let c = WelcomeViewController()
            c.viewModel = $0~>
            c.navigator = $0~>
            c.style = $0.resolve(AppStyle.self)

            return c
        }

        container.register(WelcomeSkillsViewController.self) {
            let c = WelcomeSkillsViewController()
            c.viewModel = $0~>
            c.navigator = $0~>
            c.style = $0.resolve(AppStyle.self)

            return c
        }

        container.register(WelcomeBioViewController.self) {
            let c = WelcomeBioViewController()
            c.viewModel = $0~>
            c.navigator = $0~>
            c.style = $0.resolve(AppStyle.self)

            return c
        }

        container.register(WelcomeAvatarViewController.self) {
            let c = WelcomeAvatarViewController()
            c.viewModel = $0~>
            c.navigator = $0~>
            c.style = $0.resolve(AppStyle.self)

            return c
        }

        container.storyboardInitCompleted(WelcomeViewController.self) {
            $1.viewModel = $0~>
            $1.navigator = $0~>
            $1.style = $0.resolve(AppStyle.self)
        }

        container.storyboardInitCompleted(WelcomeSkillsViewController.self) {
            $1.viewModel = $0~>
            $1.navigator = $0~>
            $1.style = $0.resolve(AppStyle.self)
        }

        container.storyboardInitCompleted(WelcomeBioViewController.self) {
            $1.viewModel = $0~>
            $1.navigator = $0~>
            $1.style = $0.resolve(AppStyle.self)
        }

        container.storyboardInitCompleted(WelcomeAvatarViewController.self) {
            $1.viewModel = $0~>
            $1.navigator = $0~>
            $1.style = $0.resolve(AppStyle.self)
        }
    }
}
