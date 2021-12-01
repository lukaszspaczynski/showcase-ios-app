//
//  DarkAppStyle+WelcomeAppStyle.swift
//  ShowcaseApp
//
//  Created by Lukasz Spaczynski on 23/11/2021.
//

extension DarkAppStyle: WelcomeAppStyle {
    var welcomeStyle: WelcomeStyle {
        WelcomeStyleFactory.dark
    }
}

private enum WelcomeStyleFactory {
    static let dark: WelcomeStyle = {
        WelcomeStyle(
            backgroundColor: DarkAppStyle.Colors.lightBlack)
    }()
}
