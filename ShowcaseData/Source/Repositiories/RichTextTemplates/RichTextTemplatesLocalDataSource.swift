//
//  RichTextTemplatesLocalDataSource.swift
//  ShowcaseData
//
//  Created by Lukasz Spaczynski on 24/11/2021.
//

import RxSwift

public protocol RichTextTemplatesLocalDataSource {
    func getTemplate(_ name: RichTextTemplate.Name) -> Observable<Result<RichTextTemplate, Error>>
}
