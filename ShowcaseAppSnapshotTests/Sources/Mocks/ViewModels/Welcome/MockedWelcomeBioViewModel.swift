//
//  MockedWelcomeBioViewModel.swift
//  ShowcaseAppSnapshotTests
//
//  Created by Lukasz Spaczynski on 27/11/2021.
//

import Foundation

@testable import ShowcaseApp

class MockedWelcomeBioViewModel: WelcomeBioViewModel, MockedViewModel {
    let outputCallback: OutputCallback

    init(outputCallback: @escaping OutputCallback) {
        self.outputCallback = outputCallback
    }
}

enum MockedWelcomeBioViewModelOutputFactory {
    typealias Output = WelcomeBioViewModelOutput

    enum MockedBioFactory {
        typealias Bio = Output.Bio

        static var bio: Bio {
            let summary = try! NSAttributedString.rtf(url: Bundle.current.url(forResource: "mocked-bio", withExtension: "rtf")!)
            let link1 = try! NSAttributedString.rtf(url: Bundle.current.url(forResource: "mocked-bio-link-1", withExtension: "rtf")!)
            let link2 = try! NSAttributedString.rtf(url: Bundle.current.url(forResource: "mocked-bio-link-2", withExtension: "rtf")!)
            let url = URL(string: "http://dummy.net")!

            return Bio(
                summary: summary,
                links: [link1: url, link2: url]
            )
        }
    }

    static func mocked(for state: Output.ViewState) -> Output {
        switch state {
        case .bio:
            return Self.bio
        case .error:
            return Self.error
        case .working:
            return Self.working
        }
    }

    static var bio: Output {
        Output(
            prevDriver: .empty(),
            nextDriver: .empty(),
            linkDriver: .empty(),
            workingDriver: .just(false),
            bioDriver: .just(MockedBioFactory.bio),
            showViewDriver: .just(.bio),
            disposables: []
        )
    }

    static var working: Output {
        Output(
            prevDriver: .empty(),
            nextDriver: .empty(),
            linkDriver: .empty(),
            workingDriver: .just(true),
            bioDriver: .empty(),
            showViewDriver: .just(.working),
            disposables: []
        )
    }

    static var error: Output {
        Output(
            prevDriver: .empty(),
            nextDriver: .empty(),
            linkDriver: .empty(),
            workingDriver: .just(false),
            bioDriver: .empty(),
            showViewDriver: .just(.error),
            disposables: []
        )
    }
}
