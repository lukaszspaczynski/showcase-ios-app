//
//  WelcomeAvatarViewModel.swift
//  ShowcaseApp
//
//  Created by Lukasz Spaczynski on 21/11/2021.
//

import RxCocoa
import RxSwift
import ShowcaseDomain
import Swinject
import SwinjectAutoregistration
import UIKit

protocol WelcomeAvatarViewModel {
    typealias Input = WelcomeAvatarViewModelInput
    typealias Output = WelcomeAvatarViewModelOutput

    func transform(_ input: Input) -> Output
}

protocol AvatarEndpoint {
    var avatarEndpoint: URL { get }
}

struct WelcomeAvatarViewModelInput {
    let loadEvent: ControlEvent<Void>
    let prevEvent: ControlEvent<Void>
    let nextEvent: ControlEvent<Void>
}

struct WelcomeAvatarViewModelOutput {
    enum ViewState {
        case error
        case working
        case avatar
    }

    struct Avatar {
        let original: UIImage
        let pixelized: [UIImage]
    }

    let prevDriver: Driver<Void>
    let nextDriver: Driver<Void>
    let workingDriver: Driver<Bool>
    let avatarDriver: Driver<Avatar>
    let showViewDriver: Driver<ViewState>
    let disposables: [Disposable]
}

class ConcreteWelcomeAvatarViewModel: WelcomeAvatarViewModel, ViewModel {
    typealias ViewState = WelcomeAvatarViewModelOutput.ViewState

    let getAvatarUseCase: GetAvatarUseCase
    let avatarEndpoint: AvatarEndpoint

    init(getAvatarUseCase: GetAvatarUseCase,
         avatarEndpoint: AvatarEndpoint)
    {
        self.getAvatarUseCase = getAvatarUseCase
        self.avatarEndpoint = avatarEndpoint
    }

    func transform(_ input: Input) -> Output {
        let getAvatarAction = getAvatarUseCase.execute(
            avatarEndpoint.avatarEndpoint)

        let workingObservable = getAvatarAction
            .executing

        let workingDriver = workingObservable
            .asDriver(onErrorJustReturn: false)

        let avatarDriver = getAvatarAction
            .elements
            .map(Self.map)
            .asDriver(onErrorDriveWith: .never())

        let showAvatarObservable = Observable<Bool>
            .just(false)
            .merge(with: [
                getAvatarAction.elements.map { _ in true },
                getAvatarAction.errors.map { _ in false },
            ])

        let showErrorObservable = Observable<Bool>
            .just(false)
            .merge(with: [
                getAvatarAction.elements.map { _ in false },
                getAvatarAction.errors.map { _ in true },
            ])

        let loadDisposable = input
            .loadEvent
            .bind(to: getAvatarAction.inputs)

        let showViewDriver = Observable
            .just(ViewState.working)
            .merge(with: [
                workingObservable.compactMap { $0 ? .working : nil },
                showAvatarObservable.compactMap { $0 ? .avatar : nil },
                showErrorObservable.compactMap { $0 ? .error : nil },
            ])
            .asDriver(onErrorDriveWith: .never())

        return WelcomeAvatarViewModelOutput(
            prevDriver: input.prevEvent.asDriver(),
            nextDriver: input.nextEvent.asDriver(),
            workingDriver: workingDriver,
            avatarDriver: avatarDriver,
            showViewDriver: showViewDriver,
            disposables: [loadDisposable]
        )
    }

    private static func map(_ avatar: GetAvatarUseCaseOutput) -> Output.Avatar {
        Output.Avatar(
            original: avatar.avatar,
            pixelized: avatar.pixelized
        )
    }
}
