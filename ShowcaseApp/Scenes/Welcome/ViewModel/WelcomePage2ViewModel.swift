//
//  WelcomePage2ViewModel.swift
//  ShowcaseApp
//
//  Created by Lukasz Spaczynski on 21/11/2021.
//

import Action
import RxCocoa
import RxSwift
import RxSwiftExt
import ShowcaseData
import ShowcaseDomain
import Swinject
import SwinjectAutoregistration

protocol WelcomePage2ViewModel {
    typealias Input = WelcomePage2ViewModelInput
    typealias Output = WelcomePage2ViewModelOutput

    func transform(_ input: Input) -> Output
}

struct WelcomePage2ViewModelInput {
    let loadEvent: ControlEvent<Void>
    let prevEvent: ControlEvent<Void>
    let nextEvent: ControlEvent<Void>
    let openLinkEvent: ControlEvent<URL>
}

struct WelcomePage2ViewModelOutput {
    enum ViewState {
        case error
        case working
        case bio
    }

    struct Bio {
        let summary: NSAttributedString
        let links: [NSAttributedString: URL]
    }

    let prevDriver: Driver<Void>
    let nextDriver: Driver<Void>
    let linkDriver: Driver<URL>
    let workingDriver: Driver<Bool>
    let bioDriver: Driver<Bio>
    let showViewDriver: Driver<ViewState>
    let disposables: [Disposable]
}

class ConcreteWelcomePage2ViewModel: WelcomePage2ViewModel, ViewModel {
    typealias ViewState = WelcomePage2ViewModelOutput.ViewState

    let getBioUseCase: GetBioUseCase

    init(getBioUseCase: GetBioUseCase) {
        self.getBioUseCase = getBioUseCase
    }

    let disposeBag = DisposeBag()

    func transform(_ input: Input) -> Output {
        let getBioAction = getBioUseCase.execute(nil)

        let workingObservable = getBioAction
            .executing

        let workingDriver = workingObservable
            .asDriver(onErrorJustReturn: false)

        let bioDriver = getBioAction
            .elements
            .map(Self.map)
            .asDriver(onErrorDriveWith: .never())

        let showBioObservable = Observable<Bool>
            .just(false)
            .merge(with: [
                getBioAction.elements.map { _ in true },
                getBioAction.errors.map { _ in false },
            ])

        let showErrorObservable = Observable<Bool>
            .just(false)
            .merge(with: [
                getBioAction.elements.map { _ in false },
                getBioAction.errors.map { _ in true },
            ])

        let loadDisposable = input
            .loadEvent
            .bind(to: getBioAction.inputs)

        let showViewDriver = Observable
            .just(ViewState.working)
            .merge(with: [
                workingObservable.compactMap { $0 ? .working : nil },
                showBioObservable.compactMap { $0 ? .bio : nil },
                showErrorObservable.compactMap { $0 ? .error : nil },
            ])
            .asDriver(onErrorDriveWith: .never())

        return WelcomePage2ViewModelOutput(
            prevDriver: input.prevEvent.asDriver(),
            nextDriver: input.nextEvent.asDriver(),
            linkDriver: input.openLinkEvent.asDriver(),
            workingDriver: workingDriver,
            bioDriver: bioDriver,
            showViewDriver: showViewDriver,
            disposables: [loadDisposable]
        )
    }

    private static func map(_ bio: GetBioUseCaseOutput) -> Output.Bio {
        let links = bio.links.reduce(into: [NSAttributedString: URL]()) { r, link in
            r[link.title] = link.url
        }

        return Output.Bio(
            summary: bio.bio,
            links: links
        )
    }
}