//
//  WelcomePagesControllerFactory.swift
//  ShowcaseApp
//
//  Created by Lukasz Spaczynski on 21/11/2021.
//

import Swinject
import SwinjectAutoregistration
import SwinjectStoryboard
import UIKit

enum WelcomePagesControllerFactory {
    enum Page {
        case first
        case second
        case third

        func identifier() -> String {
            switch self {
            case .first:
                return "WelcomePage1ViewController"
            case .second:
                return "WelcomePage2ViewController"
            case .third:
                return "WelcomePage3ViewController"
            }
        }
    }

    private static let storyboardName: String = "Welcome"

    private static func storyboard(dependencies r: Resolver) -> SwinjectStoryboard {
        SwinjectStoryboard.create(
            name: Self.storyboardName,
            bundle: Bundle.main,
            container: r
        )
    }

    static func instantiate(page: Page, dependencies r: Resolver) -> UIViewController {
        let storyboard = Self.storyboard(dependencies: r)

        return storyboard.instantiateViewController(
            identifier: page.identifier())
    }
}
