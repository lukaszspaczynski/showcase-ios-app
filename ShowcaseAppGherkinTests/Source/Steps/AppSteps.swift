//
//  AppSteps.swift
//  ShowcaseAppGherkinTests
//
//  Created by Lukasz Spaczynski on 30/11/2021.
//

import Foundation

enum AppSteps {
    static let startApp = "User starts the app"
    static let tapsElement = "User taps element with (.+) ((id)|(label))"
    static let swipesId = "User swipes (.+) on element with (.+) id"
    static let swipesLabel = "User swipes (.+) on element with (.+) label"
    static let enterScreen = "User enters (.+) screen"
    static let onPage = "User is on page with (.+) ((id)|(label))"
    static let isShownId = "View with (.+) id is ((shown)|(hidden))"
    static let isShownLabel = "View with (.+) label is ((shown)|(hidden))"
}
