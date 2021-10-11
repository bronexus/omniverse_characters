//
//  RMClient.swift
//  MVU2
//
//  Created by Dumitru on 08.10.2021.
//

import Foundation

/**
 API Client for Rick and Morty API.
 */
public struct RMClient {
    
    public init() {}
    
    /**
     Access character struct.
     - Returns: Character struct.
     */
    public func character() -> RMCharacter {
        let character = RMCharacter(client: self)
        return character
    }
    
    /**
     Access episode struct.
     - Returns: Episode struct.
     */
    public func episode() -> RMEpisode {
        let episode = RMEpisode(client: self)
        return episode
    }
    
    /**
     Access location struct.
     - Returns: Location struct.
     */
    public func location() -> RMLocation {
        let location = RMLocation(client: self)
        return location
    }
}



