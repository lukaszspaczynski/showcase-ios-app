//
//  RestResponse.swift
//  ShowcaseData
//
//  Created by Lukasz Spaczynski on 22/11/2021.
//

protocol RestResponse: Decodable {}

extension Decodable {
    static func decode<T: Decodable>(_ data: Data) -> Result<T, Error> {
        Result {
            try JSONDecoder().decode(T.self, from: data)
        }
    }
}
