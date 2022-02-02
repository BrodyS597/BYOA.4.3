//
//  Pokemon.swift
//  BYOA 4.3 - PokeAPI
//
//  Created by Brody Sears on 2/2/22.
//

import Foundation

/// pokemon "name" is first level. https://pokeapi.co/api/v2/pokemon
/// ID and Height are second level./(1...)

class Pokemon {
    
    let name : String
    let urlString: String
    let id: Int
    let height: Int

    init?(name: String, id: Int, height: Int) {
        self.name = name
        self.id = id
        self.height = height
        guard let urlString = dictionary
        self.urlString = urlString
    }
}//end of class


