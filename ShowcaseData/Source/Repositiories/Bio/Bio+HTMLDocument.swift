//
//  Bio+HTMLDocument.swift
//  ShowcaseData
//
//  Created by Lukasz Spaczynski on 22/11/2021.
//

import Kanna

public extension Bio {
    private enum Key: String, CodingKey {
        case bios = "//div[@class='body-content']/section[@class='bio inset']/div/p"
        case name = "//div[@class='name-headline']/section/h1"
        case role = "//div[@class='name-headline']/section/h2[@class='headline']/span[@class='roles']/span"
        case location = "//div[@class='name-headline']/section/h2[@class='headline']/span[@class='location']/span"
        case links = "//a[@class='social-link']"
    }

    init?(_ document: HTMLDocument) {
        let queryTexts: (Key, HTMLDocument) -> [String] =
            { $1.xpath($0.stringValue).compactMap(\.text) }
        let queryLinks: (Key, HTMLDocument) -> [(String, URL)] =
            { $1.xpath($0.stringValue).compactMap { element in

                guard let href = element["href"],
                      let url = URL(string: href),
                      let title = element["title"]
                else {
                    return nil
                }

                return (title, url)
            }}

        guard let name = queryTexts(.name, document).first,
              let role = queryTexts(.role, document).first,
              let location = queryTexts(.location, document).first
        else {
            return nil
        }

        let links = queryLinks(.links, document)
            .map { Link(title: $0, url: $1) }

        bios = queryTexts(.bios, document)
        self.links = links
        self.name = name
        self.role = role
        self.location = location
    }
}
