//
//  WelcomeViewController+UIPageViewControllerDataSource.swift
//  ShowcaseApp
//
//  Created by Lukasz Spaczynski on 14/12/2021.
//

import UIKit

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
