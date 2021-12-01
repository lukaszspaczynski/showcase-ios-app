//
//  ConcreteRichTextTemplatesLocalDataSource.swift
//  ShowcaseData
//
//  Created by Lukasz Spaczynski on 24/11/2021.
//

import RxSwift
import ShowcaseExtensions

public class ConcreteRichTextTemplatesLocalDataSource: RichTextTemplatesLocalDataSource {
    public enum DataSourceError: Error {
        case resourceNotFound
        case underlyingError(Error)
    }

    public init() {}

    public func getTemplate(_ name: RichTextTemplate.Name) -> Observable<Result<RichTextTemplate, Error>> {
        .just(Result<RichTextTemplate, Error> {
            let fileName = name.description + "-template"
            let ext = "rtf"

            guard let url = Bundle.current.url(forResource: fileName, withExtension: ext) else {
                throw DataSourceError.resourceNotFound
            }

            do {
                return try RichTextTemplate(name: name, url: url)
            } catch {
                throw DataSourceError.underlyingError(error)
            }
        })
    }
}
