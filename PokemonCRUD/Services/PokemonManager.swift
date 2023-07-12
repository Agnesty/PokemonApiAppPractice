//
//  PokemonManager.swift
//  PokemonCRUD
//
//  Created by Agnes Triselia Yudia on 12/07/23.
//

import Foundation

class PokemonManager {
    var getPokemon: [SpecificPokemon] = []
//    func fetchDataFromAPI() {
//            guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/") else {
//                return
//            }
//
//            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//                if let error = error {
//                    print("Error: \(error)")
//                    return
//                }
//
//                guard let data = data else {
//                    print("No data received")
//                    return
//                }
//
//                do {
//                    let pokemonList = try JSONDecoder().decode(Pokemon.self, from: data)
//                    DispatchQueue.main.async {
//                            self.getPokemon = pokemonList.results
//                        }
//
//                    // Accessing the names using the model
//                    for pokemon in pokemonList.results {
//                        let name = pokemon.name
//                        print("Name: \(name)")
//                    }
//                } catch {
//                    print("Error while decoding JSON: \(error)")
//                }
//            }
//
//            task.resume()
//        }
    
    func fetchDataFromAPI(completionHandler: @escaping (Pokemon) -> Void) {
            
           let pokemonResults = [Pokemon]()
        
        // Calling WebApi for get data
        
            completionHandler(pokemonResults)
        }
}
