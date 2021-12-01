//
//  RestClient.swift
//  ShowcaseData
//
//  Created by Lukasz Spaczynski on 18/11/2021.
//

public enum RestClientError: Error {
    case networkFailure(Error)
    case decodeFailure(Error)
    case emptyResponse
}

public protocol RestClient {
    typealias DispatchCompletion = (Result<Data, Error>) -> Void

    func dispatch(request: RestRequest, completion: @escaping DispatchCompletion) -> RestClientSessionDataTask
}

public protocol RestClientSessionDataTask {
    func resume()
    func cancel()
}

public extension RestClient {
    func dispatch(request: RestRequest, completion: @escaping DispatchCompletion) -> RestClientSessionDataTask {
        let session = URLSession.shared
        let url = request.url

        var httpRequest = URLRequest(url: url)
        httpRequest.httpMethod = request.method.asHttpMethod()

        let task = session.dataTask(with: httpRequest) { data, _, error in

            let result = Result<Data?, Error> {
                guard error == nil else {
                    throw error!
                }

                return data
            }
            .mapError { RestClientError.networkFailure($0) }
            .flatMap { data -> Result<Data, Error> in
                guard let data = data else {
                    return .failure(RestClientError.emptyResponse)
                }

                return .success(data)
            }

            completion(result)
        }

        return task
    }
}

private extension RestRequestMethod {
    func asHttpMethod() -> String {
        switch self {
        case .delete:
            return "DELETE"
        case .get:
            return "GET"
        case .post:
            return "POST"
        case .put:
            return "PUT"
        }
    }
}

extension URLSessionDataTask: RestClientSessionDataTask {}
