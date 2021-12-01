//
//  Result.swift
//  ShowcaseApp
//
//  Created by Lukasz Spaczynski on 24/11/2021.
//

public extension Result {
    var value: Success? {
        switch self {
        case let .success(s):
            return s
        default:
            return nil
        }
    }

    var error: Failure? {
        switch self {
        case let .failure(e):
            return e
        default:
            return nil
        }
    }

    var hasError: Bool {
        error != nil
    }

    var hasValue: Bool {
        value != nil
    }
}
