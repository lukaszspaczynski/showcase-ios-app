//
//  WelcomePage1ViewModel.swift
//  ShowcaseApp
//
//  Created by Lukasz Spaczynski on 21/11/2021.
//

import RxCocoa
import RxSwift
import Swinject
import SwinjectAutoregistration

protocol WelcomePage1ViewModel {
    typealias Input = WelcomePage1ViewModelInput
    typealias Output = WelcomePage1ViewModelOutput

    func transform(_ input: Input) -> Output
}

struct WelcomePage1ViewModelInput {
    let nextEvent: ControlEvent<Void>
}

struct WelcomePage1ViewModelOutput {
    let nextDriver: Driver<Void>
}

class ConcreteWelcomePage1ViewModel: WelcomePage1ViewModel, ViewModel {
    init() {}

    func transform(_ input: Input) -> Output {
        WelcomePage1ViewModelOutput(
            nextDriver: input.nextEvent.asDriver())
    }
}
