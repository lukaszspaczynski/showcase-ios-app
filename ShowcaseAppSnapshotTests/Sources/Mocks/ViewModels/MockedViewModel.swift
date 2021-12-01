//
//  MockedViewModel.swift
//  ShowcaseAppSnapshotTests
//
//  Created by Lukasz Spaczynski on 28/11/2021.
//

import Foundation

@testable import ShowcaseApp

protocol MockedViewModel: ViewModel {
    typealias OutputCallback = () -> Output

    var outputCallback: OutputCallback { get }

    func transform(_: Input) -> Output
}

extension MockedViewModel {
    func transform(_: Input) -> Output {
        outputCallback()
    }
}
