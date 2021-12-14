//
//  MockedRichTextTemplatesLocalDataSource.swift
//  ShowcaseDataMocks
//
//  Created by Lukasz Spaczynski on 26/11/2021.
//

import Foundation
import RxSwift
import ShowcaseData

public final class MockedRichTextTemplatesLocalDataSource: RichTextTemplatesLocalDataSource {
    public init() {}

    public enum GetTemplateResult {
        case valid
        case empty
        case template(template: RichTextTemplate)
        case name(name: RichTextTemplate.Name)
        case invalid(error: Error)
    }

    public var getTemplateInvoked: Bool = false
    public var getTemplateInvokedResult: GetTemplateResult = .empty
    public func getTemplate(_ name: RichTextTemplate.Name) -> Observable<Result<RichTextTemplate, Error>> {
        getTemplateInvoked = true

        return Self.resolveGetTemplateResult(getTemplateInvokedResult, name)
    }
}

extension MockedRichTextTemplatesLocalDataSource {
    private static func resolveGetTemplateResult(
        _ type: GetTemplateResult,
        _ name: RichTextTemplate.Name
    ) ->
        Observable<Result<RichTextTemplate, Error>>
    {
        switch type {
        case .valid:
            return .just(.success(Self.load(template: name.description)!))
        case .empty:
            return .empty()
        case let .template(template):
            return .just(.success(template))
        case let .name(name):
            return .just(.success(Self.load(template: name.description)!))
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
