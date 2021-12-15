//
//  AppAssembler.swift
//  ShowcaseApp
//
//  Created by Lukasz Spaczynski on 20/11/2021.
//

import Swinject

enum AppResolver {
    static var `default`: Resolver = {
        AssemblerFactory.instantiate().resolver
    }()
}
