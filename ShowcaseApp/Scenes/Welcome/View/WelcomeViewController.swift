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

    lazy var orderedViewControllers: [UIViewController] = {
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
