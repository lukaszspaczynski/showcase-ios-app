//
//  MockedRichTextTemplateNames.swift
//  ShowcaseDataMocks
//
//  Created by Lukasz Spaczynski on 26/11/2021.
//

import Foundation

public enum MockedRichTextTemplateNames: String, CaseIterable, CustomStringConvertible {
    case dummy
    case notExisting
    case bioLink
    case bio

    public var description: String {
        "mocked-" + rawValue.lowercased() + "-template"
    }
}
