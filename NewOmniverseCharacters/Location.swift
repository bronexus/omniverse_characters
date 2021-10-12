//
//  Location.swift
//  NewOmniverseCharacters
//
//  Created by Dumitru on 12.10.2021.
//

import Foundation

struct Location: Codable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: String
    let created: String
}
