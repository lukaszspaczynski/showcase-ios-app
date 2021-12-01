//
//  XCTestCase+Extensions.swift
//  ShowcaseAppSnapshotTests
//
//  Created by Lukasz Spaczynski on 27/11/2021.
//

import Foundation
import SnapshotTesting
import XCTest

extension XCTestCase {
    static var testingDevices: [String: ViewImageConfig] {
        [
            "iPhone8": .iPhone8,
            "iPhone8Plus": .iPhone8Plus,
            "iPhoneX": .iPhoneX,
            "iPhoneSe": .iPhoneSe,
            "iPhoneXr": .iPhoneXr,
            "iPhoneXsMax": .iPhoneXsMax,
        ]
    }
}
