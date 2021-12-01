//
//  Bundle.swift
//  ShowcaseMocks
//
//  Created by Lukasz Spaczynski on 22/11/2021.
//

import UIKit

extension Bundle {
    static var current: Bundle {
        class __ {}
        return Bundle(for: __.self)
    }
}
