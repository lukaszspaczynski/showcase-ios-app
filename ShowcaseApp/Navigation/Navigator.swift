//
//  Navigator.swift
//  ShowcaseApp
//
//  Created by Lukasz Spaczynski on 21/11/2021.
//

import Swinject
import UIKit

protocol Navigator {
    func handle(navigation: Navigation, animated: Bool)
}

enum Navigation {
    enum Section {
        case home
        case messages
        case notifications
        case profile
    }

    struct Screen {
        let viewController: (Resolver) -> UIViewController
    }

    case section(Section)
    case push(Screen)
    case show(Screen)
    case root(Screen)
    case next
    case prev
    case modal(
        Screen,
        UIModalPresentationStyle = .fullScreen,
        completion: (() -> Void)? = nil
    )
}
