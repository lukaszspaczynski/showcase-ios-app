//
//  WelcomePage3ViewModel.swift
//  ShowcaseApp
//
//  Created by Lukasz Spaczynski on 21/11/2021.
//

import RxCocoa
import RxSwift
import Swinject
import SwinjectAutoregistration

protocol WelcomePage3ViewModel {
    typealias Input = WelcomePage3ViewModelInput
    typealias Output = WelcomePage3ViewModelOutput

    func transform(_ input: Input) -> Output
}

struct WelcomePage3ViewModelInput {
    let prevEvent: ControlEvent<Void>
    let startEvent: ControlEvent<Void>
}

struct WelcomePage3ViewModelOutput {
    let prevDriver: Driver<Void>
    let startDriver: Driver<Void>
}

class ConcreteWelcomePage3ViewModel: WelcomePage3ViewModel, ViewModel {
    init() {}

    func transform(_ input: Input) -> Output {
        WelcomePage3ViewModelOutput(
            prevDriver: input.prevEvent.asDriver(),
            startDriver: input.startEvent.asDriver()
        )
    }
}
