//
//  MockedRestClient.swift
//  ShowcaseMocks
//
//  Created by Lukasz Spaczynski on 20/11/2021.
//

import ShowcaseData

public class MockedRestClient: RestClient {
    public init() {}

    public var dispatchInvoked: Bool = false
    public var dispatchInvokedResult: Result<Data, Error>?
    public func dispatch(request _: RestRequest, completion: @escaping DispatchCompletion) -> RestClientSessionDataTask {
        dispatchInvoked = true

        let dataTask = MockedRestClientSessionDataTask()
        let dispatchResult = dispatchInvokedResult

        dataTask.onResumeAction = { () in
            if let dispatchResult = dispatchResult {
                completion(dispatchResult)
            }
        }

        return dataTask
    }
}
