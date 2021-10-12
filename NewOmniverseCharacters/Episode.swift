//
//  Episode.swift
//  NewOmniverseCharacters
//
//  Created by Dumitru on 12.10.2021.
//

import Foundation

struct Episode: Codable {
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
}
