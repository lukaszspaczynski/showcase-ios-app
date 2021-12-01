//
//  ConcreteBioRepository.swift
//  ShowcaseData
//
//  Created by Lukasz Spaczynski on 22/11/2021.
//

import RxSwift

public class ConcreteBioRepository: BioRepository {
    private var remoteDataSource: BioWebDataSource

    public init(
        remoteDataSource: BioWebDataSource
    ) {
        self.remoteDataSource = remoteDataSource
    }

    public func getBio() -> Observable<Result<Bio, Error>> {
        remoteDataSource.getBio()
    }
}
