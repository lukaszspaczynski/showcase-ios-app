//
//  MockedRichTextTemplatesRepository.swift
//  ShowcaseDataMocks
//
//  Created by Lukasz Spaczynski on 25/11/2021.
//

import Foundation
import RxSwift
import ShowcaseData

public class MockedRichTextTemplatesRepository: RichTextTemplatesRepository {
    public init() {}

    public enum GetTemplateResult {
        case empty
        case valid
        case template(RichTextTemplate)
        case name(RichTextTemplate.Name)
        case map((RichTextTemplate.Name) -> MockedRichTextTemplateNames)
        case invalid(error: Error)
    }

    public var getTemplateInvoked: Bool = false
    public var getTemplateInvokedResult: GetTemplateResult = .empty
    public func getTemplate(_ name: RichTextTemplate.Name) -> Observable<Result<RichTextTemplate, Error>> {
        getTemplateInvoked = true
        return Self.resolveTemplateResult(getTemplateInvokedResult, name)
    }
}

extension MockedRichTextTemplatesRepository {
    private static func resolveTemplateResult(
        _ type: GetTemplateResult,
        _ name: RichTextTemplate.Name
    ) ->
        Observable<Result<RichTextTemplate, Error>>
    {
        switch type {
        case .valid:
            return .just(.success(Self.load(template: name.description)!))

        case let .template(template):
            return .just(.success(template))

        case let .name(name):
            return .just(.success(Self.load(template: name.description)!))

        case let .map(result):
            let newName = result(name)
            let template = Self.load(template: newName.description)!

            return .just(.success(template))

        case .empty:
            return .empty()

        case let .invalid(error):
            return .just(.failure(error))
        }
    }

    private static func load(template name: String) -> RichTextTemplate? {
        guard let url = Bundle.current.url(forResource: name, withExtension: "rtf"),
              let result = try? RichTextTemplate(
                  name: name,
                  url: url
              )
        else {
            return nil
        }

        return result
    }
}
