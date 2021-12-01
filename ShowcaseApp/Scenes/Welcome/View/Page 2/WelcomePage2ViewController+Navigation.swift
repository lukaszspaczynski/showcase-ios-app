//
//  WelcomePage2ViewController+Navigation.swift
//  ShowcaseApp
//
//  Created by Lukasz Spaczynski on 21/11/2021.
//

import Foundation
import SafariServices
import Swinject

extension WelcomePage2ViewController {
    func navigateNext() {
        navigator.handle(navigation: .next, animated: true)
    }

    func navigatePrev() {
        navigator.handle(navigation: .prev, animated: true)
    }

    func navigateTo(url: URL) {
        let controller: (Resolver) -> UIViewController = { _ in
            let sf = SFSafariViewController(url: url)
            sf.modalPresentationStyle = .popover

            return sf
        }

        navigator.handle(
            navigation: .show(Navigation.Screen(viewController: controller)), animated: true
        )
    }
}
