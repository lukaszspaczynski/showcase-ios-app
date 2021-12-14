//
//  MockedRestClientSessionDataTask.swift
//  ShowcaseMocks
//
//  Created by Lukasz Spaczynski on 20/11/2021.
//

import ShowcaseData

public final class MockedRestClientSessionDataTask: RestClientSessionDataTask {
    public var resumeInvoked: Bool = false
    public var onResumeAction: (() -> Void)?
    public func resume() {
        resumeInvoked = true
        onResumeAction?()
    }

    public var cancelInvoked: Bool = false
    public func cancel() {
        cancelInvoked = true
    }
}
