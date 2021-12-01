//
//  RestRequest.swift
//  ShowcaseData
//
//  Created by Lukasz Spaczynski on 18/11/2021.
//

public enum RestRequestMethod {
    case post
    case get
    case put
    case delete
}

public protocol RestRequest {
    var url: URL { get }
    var method: RestRequestMethod { get }
}

public extension RestRequest {
    var method: RestRequestMethod {
        .get
    }
}
