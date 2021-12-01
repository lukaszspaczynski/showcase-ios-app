//
//  WelcomeViewController.swift
//  ShowcaseApp
//
//  Created by Lukasz Spaczynski on 21/11/2021.
//

import Swinject
import SwinjectAutoregistration
import UIKit

final class WelcomeViewController: UIPageViewController {
    var viewModel: WelcomeViewModel!
    var navigator: Navigator!
    var style: WelcomeAppStyle!

    var provideViewControllers: (() -> [UIViewController])!

    private lazy var orderedViewControllers: [UIViewController] = {
        provideViewControllers()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let first = orderedViewControllers.first else {
            return
        }

        dataSource = self
        setViewControllers(
            [first],
            direction: .forward,
            animated: false
        )

        apply(style: style)
        applyAccessibility()
    }
}

extension WelcomeViewController: UIPageViewControllerDataSource {
    func pageViewController(_: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = orderedViewControllers
            .firstIndex(of: viewController)
        else {
            return nil
        }

        let count = orderedViewControllers.count
        let prevIndex = ((currentIndex + count) - 1) % count

        guard prevIndex >= 0,
              prevIndex < count
        else {
            return nil
        }

        return orderedViewControllers[prevIndex]
    }

    func pageViewController(_: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = orderedViewControllers
            .firstIndex(of: viewController)
        else {
            return nil
        }

        let count = orderedViewControllers.count
        let prevIndex = (currentIndex + 1) % count

        guard prevIndex >= 0,
              prevIndex < count
        else {
            return nil
        }

        return orderedViewControllers[prevIndex]
    }
}
