//
//  MocksAssemblerFactory.swift
//  ShowcaseAppGherkinTests
//
//  Created by Lukasz Spaczynski on 30/11/2021.
//

import Swinject
import SwinjectAutoregistration

@testable import ShowcaseApp

enum MocksAssemblerFactory {
    static func instantiate() -> Assembler {
        let cantainerAssemblies: [Assembly] = [
            MocksDomainAssembly(),
        ]

        let cantainerAssembler = Assembler(
            cantainerAssemblies,
            parent: nil,
            defaultObjectScope: .container
        )

        let transientAssemblies: [Assembly] = [
            ViewControllerAssembly(),
        ]

        let transientAssembler = Assembler(
            transientAssemblies,
            parent: cantainerAssembler,
            defaultObjectScope: .transient
        )

        return transientAssembler
    }
}
