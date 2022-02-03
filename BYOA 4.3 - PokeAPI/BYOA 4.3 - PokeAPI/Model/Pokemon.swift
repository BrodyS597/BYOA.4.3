//
//  Pokemon.swift
//  BYOA 4.3 - PokeAPI
//
//  Created by Brody Sears on 2/2/22.
//

import Foundation

struct Keys {
    static let kUrl: String = "url"
    static let kName: String = "name"
}

class Pokemon {
    
    let urlString: String
    
    init?(dictionary: [String: Any]) {
        guard let urlString = dictionary[Keys.kUrl] as? String else { return nil }
        self.urlString = urlString
    }
}

class PokemonDetail {
    
    let name : String
    let id: Int
    let height: Int
    
    init?(detailDictionary: [String: Any]) {
        guard let name = detailDictionary["name"] as? String,
              let id = detailDictionary["id"] as? Int,
              let height = detailDictionary["height"] as? Int
        else { return nil }
        
        self.name = name
        self.id = id
        self.height = height
    }
}
