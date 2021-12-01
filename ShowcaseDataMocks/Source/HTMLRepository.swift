//
//  HTMLRepository.swift
//  ShowcaseMocks
//
//  Created by Lukasz Spaczynski on 22/11/2021.
//

import UIKit

public enum HTMLRepository: String {
    public enum HTMLRepositoryError: Error {
        case unableToLoad
    }

    case bioResponseValid

    private func url(bundle: Bundle) -> URL? {
        let filename =
            rawValue.first!.uppercased() +
            rawValue.dropFirst()

        return bundle.url(forResource: filename, withExtension: "html")
    }

    public func data() throws -> Data {
        let bundle = Bundle.current

        guard let url = url(bundle: bundle) else {
            throw HTMLRepositoryError.unableToLoad
        }

        return try Data(contentsOf: url)
    }
}
