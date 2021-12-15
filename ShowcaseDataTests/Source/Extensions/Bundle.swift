//
//  Bundle.swift
//  ShowcaseDataTests
//
//  Created by Lukasz Spaczynski on 15/12/2021.
//

import Foundation

extension Bundle {
    static var current: Bundle {
        class __ {}
        return Bundle(for: __.self)
    }
}
