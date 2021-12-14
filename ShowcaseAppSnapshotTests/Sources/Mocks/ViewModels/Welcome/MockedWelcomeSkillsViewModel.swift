//
//  MockedWelcomeSkillsViewModel.swift
//  ShowcaseAppSnapshotTests
//
//  Created by Lukasz Spaczynski on 28/11/2021.
//

import Foundation

@testable import ShowcaseApp

final class MockedWelcomeSkillsViewModel: WelcomeSkillsViewModel, MockedViewModel {
    let outputCallback: OutputCallback

    init(outputCallback: @escaping OutputCallback) {
        self.outputCallback = outputCallback
    }
}
