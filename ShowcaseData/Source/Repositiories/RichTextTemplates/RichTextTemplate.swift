//
//  RichTextTemplate.swift
//  ShowcaseData
//
//  Created by Lukasz Spaczynski on 24/11/2021.
//

public enum RichTextTemplateName: CaseIterable, CustomStringConvertible {
    case bio
    case bioLink

    public var description: String {
        switch self {
        case .bio:
            return "bio"
        case .bioLink:
            return "bio-link"
        }
    }
}

public struct RichTextTemplate {
    public typealias Name = CustomStringConvertible
    public typealias TemplateValuesCallback = () -> [String: String]

    public let name: Name
    public let value: NSAttributedString

    public func evaluate(_ callback: TemplateValuesCallback) -> NSAttributedString {
        let items = callback()

        var result = value

        for item in items {
            result = result
                .replacing(
                    placeholder: item.key,
                    with: item.value
                )
        }

        return result
    }
}

public extension RichTextTemplate {
    init(name: Name, url: URL) throws {
        self.init(
            name: name,
            value: try NSAttributedString.rtf(url: url)
        )
    }
}
