//
//  WelcomeSkillsViewModel.swift
//  ShowcaseApp
//
//  Created by Lukasz Spaczynski on 21/11/2021.
//

import RxCocoa
import RxSwift
import Swinject
import SwinjectAutoregistration

protocol WelcomeSkillsViewModel {
    typealias Input = WelcomeSkillsViewModelInput
    typealias Output = WelcomeSkillsViewModelOutput

    func transform(_ input: Input) -> Output
}

struct WelcomeSkillsViewModelInput {
    let prevEvent: ControlEvent<Void>
    let nextEvent: ControlEvent<Void>
}

struct WelcomeSkillsViewModelOutput {
    let prevDriver: Driver<Void>
    let nextDriver: Driver<Void>
}

final class ConcreteWelcomeSkillsViewModel: WelcomeSkillsViewModel, ViewModel {
    init() {}

    func transform(_ input: Input) -> Output {
        WelcomeSkillsViewModelOutput(
            prevDriver: input.prevEvent.asDriver(),
            nextDriver: input.nextEvent.asDriver()
        )
    }
}
