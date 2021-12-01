//
//  BioWebRequest.swift
//  ShowcaseData
//
//  Created by Lukasz Spaczynski on 22/11/2021.
//

struct BioWebRequest: RestRequest {
    let endpoint: BioWebEndpoint

    init(endpoint: BioWebEndpoint) {
        self.endpoint = endpoint
    }

    var url: URL {
        endpoint.bioEndpoint
    }
}
