//
//  BioRepository.swift
//  ShowcaseData
//
//  Created by Lukasz Spaczynski on 22/11/2021.
//

import RxSwift

public protocol BioRepository {
    func getBio() -> Observable<Result<Bio, Error>>
}
