//
//  MockedWelcomePage3ViewModel.swift
//  ShowcaseAppSnapshotTests
//
//  Created by Lukasz Spaczynski on 28/11/2021.
//

import Foundation

@testable import ShowcaseApp

class MockedWelcomePage3ViewModel: WelcomePage3ViewModel, MockedViewModel {
    let outputCallback: OutputCallback

    init(outputCallback: @escaping OutputCallback) {
        self.outputCallback = outputCallback
    }
}
