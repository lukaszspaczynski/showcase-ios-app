//
//  Navigation+Welcome.swift
//  ShowcaseApp
//
//  Created by Lukasz Spaczynski on 21/11/2021.
//

extension Navigation.Screen {
    static func welcome() -> Self {
        .init {
            WelcomeViewControllerFactory
                .instantiate(dependencies: $0)
        }
    }

    static func welcome(_ pages: [WelcomeViewControllerFactory.Page]) -> Self {
        .init {
            WelcomeViewControllerFactory
                .instantiate(dependencies: $0, pages: pages)
        }
    }
}
