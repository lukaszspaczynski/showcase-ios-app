//
//  MockedWelcomeAvatarViewModel.swift
//  ShowcaseAppSnapshotTests
//
//  Created by Lukasz Spaczynski on 28/11/2021.
//

import Foundation
import UIKit

@testable import ShowcaseApp

final class MockedWelcomeAvatarViewModel: WelcomeAvatarViewModel, MockedViewModel {
    let outputCallback: OutputCallback

    init(outputCallback: @escaping OutputCallback) {
        self.outputCallback = outputCallback
    }
}

enum MockedWelcomeAvatarViewModelOutputFactory {
    typealias Output = WelcomeAvatarViewModelOutput

    enum MockedAvatarFactory {
        typealias Avatar = Output.Avatar

        static var avatar: Avatar {
            let image = UIImage(named: "mocked-avatar.jpeg", in: Bundle.current, with: nil)!

            return Avatar(
                original: image,
                pixelized: [image]
            )
        }
    }

    static func mocked(for state: Output.ViewState) -> Output {
        switch state {
        case .avatar:
            return Self.avatar
        case .error:
            return Self.error
        case .working:
            return Self.working
        }
    }

    static var avatar: Output {
        Output(
            prevDriver: .empty(),
            nextDriver: .empty(),
            workingDriver: .just(false),
            avatarDriver: .just(MockedAvatarFactory.avatar),
            showViewDriver: .just(.avatar),
            disposables: []
        )
    }

    static var working: Output {
        Output(
            prevDriver: .empty(),
            nextDriver: .empty(),
            workingDriver: .just(true),
            avatarDriver: .empty(),
            showViewDriver: .just(.working),
            disposables: []
        )
    }

    static var error: Output {
        Output(
            prevDriver: .empty(),
            nextDriver: .empty(),
            workingDriver: .just(false),
            avatarDriver: .empty(),
            showViewDriver: .just(.error),
            disposables: []
        )
    }
}
