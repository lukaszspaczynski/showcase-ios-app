//
//  WelcomeViewModel.swift
//  ShowcaseApp
//
//  Created by Lukasz Spaczynski on 21/11/2021.
//

import Swinject
import SwinjectAutoregistration

protocol WelcomeViewModel {
    typealias Input = Void
    typealias Output = Void

    func transform(_ input: Input) -> Output
}

final class ConcreteWelcomeViewModel: WelcomeViewModel, ViewModel {
    init() {}

    func transform(_: Input) -> Output {}
}
