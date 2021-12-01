//
//  WelcomeViewControllerFactory.swift
//  ShowcaseApp
//
//  Created by Lukasz Spaczynski on 21/11/2021.
//

import Swinject
import SwinjectAutoregistration
import SwinjectStoryboard
import UIKit

enum WelcomeViewControllerFactory {
    typealias Page = WelcomePagesControllerFactory.Page

    private static let storyboardName: String = "Welcome"

    private static func storyboard(dependencies r: Resolver) -> SwinjectStoryboard {
        SwinjectStoryboard.create(
            name: Self.storyboardName,
            bundle: Bundle.main,
            container: r
        )
    }

    static func instantiate(dependencies r: Resolver) -> WelcomeViewController {
        Self.instantiate(dependencies: r, pages: [.first, .second, .third])
    }

    static func instantiate(dependencies r: Resolver, pages: [Page]) -> WelcomeViewController {
        let storyboard = Self.storyboard(dependencies: r)

        let page: WelcomeViewController = storyboard.instantiateViewController(
            identifier: "WelcomeViewController")

        page.provideViewControllers = {
            pages.map { WelcomePagesControllerFactory.instantiate(page: $0, dependencies: r) }
        }

        return page
    }
}
