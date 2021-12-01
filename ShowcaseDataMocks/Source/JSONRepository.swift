//
//  JSONRepository.swift
//  ShowcaseDataTests
//
//  Created by Lukasz Spaczynski on 18/11/2021.
//

import Foundation
import UIKit

public enum JSONRepository: String {
    public enum JSONRepositoryError: Error {
        case unableToLoad
    }

    case moviesResponseValid

    private func url(bundle: Bundle) -> URL? {
        let filename =
            rawValue.first!.uppercased() +
            rawValue.dropFirst()

        return bundle.url(forResource: filename, withExtension: "json")
    }

    public func data() throws -> Data {
        let bundle = Bundle.current

        guard let url = url(bundle: bundle) else {
            throw JSONRepositoryError.unableToLoad
        }

        return try Data(contentsOf: url)
    }

    public func decoded<T: Decodable>() throws -> T? {
        let data = try self.data()

        return try JSONDecoder().decode(T.self, from: data)
    }
}
