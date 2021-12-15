//
//  AssemblerFactory.swift
//  ShowcaseApp
//
//  Created by Lukasz Spaczynski on 20/11/2021.
//

import Swinject
import SwinjectAutoregistration

enum AssemblerFactory {
    static func instantiate() -> Assembler {
        let cantainerAssemblies: [Assembly] = [
            DataAssembly(),
            DomainAssembly(),
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
