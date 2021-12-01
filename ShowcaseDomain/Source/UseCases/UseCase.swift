//
//  UseCase.swift
//  ShowcaseDomain
//
//  Created by Lukasz Spaczynski on 19/11/2021.
//

public protocol UseCase {
    associatedtype Input
    associatedtype Output

    func execute(_ input: Input) -> Output
}
