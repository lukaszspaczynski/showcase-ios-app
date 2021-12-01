//
//  ConcreteNavigator.swift
//  ShowcaseApp
//
//  Created by Lukasz Spaczynski on 21/11/2021.
//

import Swinject
import UIKit

final class ConcreteNavigator: Navigator {
    private var dependencies: Resolver

    init(dependencies: Resolver) {
        self.dependencies = dependencies
    }

    func handle(navigation: Navigation, animated: Bool) {
        switch navigation {
        case let .root(screen):
            setRoot(screen)
        case let .show(screen):
            show(screen, animated: animated)
        case .next:
            nextPage(animated: animated)
        case .prev:
            prevPage(animated: animated)
        default:
            break
        }
    }

    private func show(_ screen: Navigation.Screen, animated: Bool) {
        guard let top = topController() else {
            return
        }

        top.present(
            screen.viewController(dependencies),
            animated: animated
        )
    }

    private func nextPage(animated: Bool) {
        guard let top = topController() as? UIPageViewController,
              let current = top.viewControllers?.first,
              let next = top
              .dataSource?
              .pageViewController(
                  top,
                  viewControllerAfter: current
              )
        else {
            return
        }

        top.setViewControllers(
            [next],
            direction: .forward,
            animated: animated
        )
    }

    private func prevPage(animated: Bool) {
        guard let top = topController() as? UIPageViewController,
              let current = top.viewControllers?.first,
              let prev = top
              .dataSource?
              .pageViewController(
                  top,
                  viewControllerBefore: current
              )
        else {
            return
        }

        top.setViewControllers(
            [prev],
            direction: .reverse,
            animated: animated
        )
    }

    private func setRoot(_ screen: Navigation.Screen) {
        guard let keyWindow = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first else {
            return
        }

        keyWindow.rootViewController = screen.viewController(dependencies)
    }

    private func topController() -> UIViewController? {
        let keyWindow = UIApplication.shared.windows.filter { $0.isKeyWindow }.first

        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }

            return topController
        }

        return nil
    }
}
