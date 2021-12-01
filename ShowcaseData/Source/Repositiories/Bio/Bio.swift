//
//  Bio.swift
//  ShowcaseData
//
//  Created by Lukasz Spaczynski on 22/11/2021.
//

public struct Bio {
    public struct Link {
        public var title: String
        public var url: URL
    }

    public var bios: [String]
    public var name: String
    public var role: String
    public var location: String
    public var links: [Link]
}
