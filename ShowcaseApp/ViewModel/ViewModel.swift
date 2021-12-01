//
//  ViewModel.swift
//  ShowcaseApp
//
//  Created by Lukasz Spaczynski on 20/11/2021.
//

protocol ViewModel {
    associatedtype Input
    associatedtype Output

    func transform(_ input: Input) -> Output
}
