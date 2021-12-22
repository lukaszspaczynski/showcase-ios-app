//
//  Endpoints.swift
//  ShowcaseApp
//
//  Created by Lukasz Spaczynski on 20/11/2021.
//

import Foundation
import ShowcaseData

struct Endpoints:
    BioWebEndpoint,
    AvatarEndpoint
{
    private init() {}

    static var shared: Endpoints = {
        Endpoints()
    }()

    var bioEndpoint: URL {
        URL(string: "https://about.me/lukasz.spaczynski")!
    }

    var avatarEndpoint: URL {
        URL(string: "https://avatars.githubusercontent.com/u/3204486")!
    }
}
