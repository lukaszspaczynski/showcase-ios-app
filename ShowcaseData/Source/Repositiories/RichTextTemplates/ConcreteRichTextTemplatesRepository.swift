//
//  ConcreteRichTextTemplatesRepository.swift
//  ShowcaseData
//
//  Created by Lukasz Spaczynski on 24/11/2021.
//

import RxSwift

public final class ConcreteRichTextTemplatesRepository: RichTextTemplatesRepository {
    private var localDataSource: RichTextTemplatesLocalDataSource

    public init(
        localDataSource: RichTextTemplatesLocalDataSource
    ) {
        self.localDataSource = localDataSource
    }

    public func getTemplate(_ name: RichTextTemplate.Name) -> Observable<Result<RichTextTemplate, Error>> {
        localDataSource.getTemplate(name)
    }
}
