//
//  Character.swift
//  NewOmniverseCharacters
//
//  Created by Dumitru on 11.10.2021.
//

import Foundation

//public class CharacterAPI {
//    
////    public func getCharactersPageByURL(urlString: String) {
////        let downloadURL = URL(string: urlString)
////        guard let url = downloadURL else { return }
////        URLSession.shared.dataTask(with: url) { data, urlResponse, error in
////            guard let data = data, urlResponse != nil, error == nil else {
////                print("Character download Error")
////                return
////            }
////            print("Character download Succes")
////            do {
////                let decoder = JSONDecoder()
////                let response = try decoder.decode(self.CharacterPageResponse, from: data)
////            } catch {
////                
////            }
////            
////        }.resume()
////    }
//}

    
    struct CharacterPageResponse: Codable {
        let info: PageInfo
        let results: [SingleCharacter]
    }
    
    struct PageInfo: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
    
    public struct SingleCharacter: Codable, Identifiable {
        public let id: Int
        public let name: String
        public let status: String
        public let species: String
        public let type: String
        public let gender: String
        public let origin: CharacterOrigin
        public let location: CharacterLocation
        public let image: String
        public let episode: [String]
        public let url: String
        public let created: String
    }
    
    public struct CharacterOrigin: Codable {
        public let name: String
        public let url: String?
    }
    
    public struct CharacterLocation: Codable {
        public let name: String
        public let url: String?
    }

