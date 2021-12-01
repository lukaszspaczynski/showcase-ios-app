//
//  NSAttributedString+RTF.swift
//  ShowcaseData
//
//  Created by Lukasz Spaczynski on 24/11/2021.
//

import UIKit

public extension NSAttributedString {
    static func rtf(url: URL) throws -> NSAttributedString {
        let options = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.rtf]
        return try NSAttributedString(url: url, options: options, documentAttributes: nil)
    }
}

public extension NSAttributedString {
    func replacing(placeholder: String, with valueString: String) -> NSAttributedString {
        if let range = string.range(of: placeholder) {
            let nsRange = NSRange(range, in: string)
            let mutableText = NSMutableAttributedString(attributedString: self)
            mutableText.replaceCharacters(in: nsRange, with: valueString)
            return mutableText as NSAttributedString
        }
        return self
    }
}
