//
//  NetworkController.swift
//  BYOA 4.3 - PokeAPI
//
//  Created by Brody Sears on 2/2/22.
//

import Foundation

class NetworkController {
    
    // MARK: - URL
    static private let baseURLString = "https://pokeapi.co/api/v2"
    static private let kPokemonComponent = "/pokemon"
    
    //Fetch func
    static func fetchPokemonList( completion: @escaping ([Pokemon]?) -> Void) {
        
        //constructing the url
        guard let baseURL = URL(string: baseURLString) else { return }
        let finalURL = baseURL.appendingPathComponent(kPokemonComponent)
        print("the final url is", finalURL)
        
        //start the DATA TASK
        URLSession.shared.dataTask(with: finalURL) { pokemonData, _, error in
            //checking for an error
            if let error = error {
                print("Encountered an error bro: \(error.localizedDescription)")
                completion(nil)
            }
            if let data = pokemonData {
                //If there is data
                do {
                    //try to decode it
                    if let topLevelDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        if let resultsArray = topLevelDictionary["results"] as? [[String: Any]] {
                            //fo in loop, retrieve URL, then make 2nd network call, in second, create pokemon with name id height.
                            //call 2nd network request, within, init the pokemon object and then put it temp array and completion(array)
                            var tempPokemonArray: [Pokemon] = []
                            for pokemonURLDictionary in resultsArray {
                                guard let pokemonURLString = pokemonURLDictionary["url"] as? String else { return }
                                fetchPokemonDetails(urlString: pokemonURLString) { pokemon in
                                    guard let pokemon = pokemon else { return }
                                    tempPokemonArray.append(pokemon)
                                }
                                completion(tempPokemonArray)
                            }
                        }
                    }
                } catch {
                    print("Error while decoding:", error.localizedDescription)
                    completion(nil)
                }
            }
        }.resume()
    }
    
    
    //second network call (needed as API leads to dif URL for the ID and height). parse in for id and height
    
    static func fetchPokemonDetails(urlString: String, completion: @escaping (Pokemon?) -> Void) {
        
        //contructing the url
        guard let baseURL = URL(string: baseURLString) else { return }
        let finalURL = baseURL.appendingPathComponent(pokemon.urlString)
        
    }
    
    
}// end of class