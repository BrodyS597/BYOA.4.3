//
//  PokemonTableViewController.swift
//  BYOA 4.3 - PokeAPI
//
//  Created by Brody Sears on 2/2/22.
//

import UIKit

class PokemonTableViewController: UITableViewController {
    
    var pokemonDetails: [PokemonDetail] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkController.fetchPokemonList()  { pokemonArray in
            guard let pokemonArray = pokemonArray else { return }
            
            //creating a DispatchGroup called dispatchGroup, which will allow us to monitor this group of tasks that are enetered into the dispatchGroup. It will notify to execute a table reload on the main queue once all tasks leave the dispatchGroup
            let dispatchGroup = DispatchGroup()
            for pokemon in pokemonArray {
                
                //we enter the dispatchGroup right before we call a func that we need to monitor
                dispatchGroup.enter()
                NetworkController.fetchPokemonDetails(urlString: pokemon.urlString) { pokemonDetailEscapedWith in
                    guard let pokemonDetailEscapedWith = pokemonDetailEscapedWith else { return }
                    self.pokemonDetails.append(pokemonDetailEscapedWith)
                    
                    //we leave the dispatchGroup once all sub tasks of an individual task are complete
                    dispatchGroup.leave()
                }
            }
            //the dispatchGroup "notifies" once all tasks that were monitored have left the dispatchGroup. Which calls dispatchGroup.notify and allows us to execute code on the main thread.
            dispatchGroup.notify(queue: .main) {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemonDetails.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokeCell", for: indexPath)
        let pokemon = pokemonDetails[indexPath.row]
        cell.textLabel?.text = pokemon.name
        cell.detailTextLabel?.text = "ID: \(pokemon.id), height: \(pokemon.height)"
        return cell
    }
}// end of class
