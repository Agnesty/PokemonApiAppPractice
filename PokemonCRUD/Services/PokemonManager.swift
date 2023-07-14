//
//  PokemonManager.swift
//  PokemonCRUD
//
//  Created by Agnes Triselia Yudia on 12/07/23.
//

import Foundation

class PokemonManager {
    
    func fetchDataFromAPI(completionHandler: @escaping (Pokemon) -> Void) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?offset=0&limit=100") else { return }
        
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                // handle error
                if let error = error {
                        print("Failed to fetch data with error: ", error.localizedDescription)
                        return
                    }
                guard let data = data,                              // is there data
                    let response = response as? HTTPURLResponse,  // is there HTTP response
                    200 ..< 300 ~= response.statusCode,           // is statusCode 2XX
                    error == nil                                  // was there no error
                        
                    else { return }
                 
                    do {
                        guard let pokemon = try? JSONDecoder().decode(Pokemon.self, from: data) else { return }
                        completionHandler(pokemon)
                        
                        for pok in pokemon.results {
                            let name = pok.name
                            print("Name: \(name)")
                        }

                    }

                }.resume()
        
        }
    
    func getDetail(abilitiesURL: String, completion: @escaping (DetailPokemon) -> Void) {
        let url = URL(string: abilitiesURL)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if let error = error {
                    print("Failed to fetch data with error: ", error.localizedDescription)
                    return
                }
            guard let data = data,                              // is there data
                let response = response as? HTTPURLResponse,  // is there HTTP response
                200 ..< 300 ~= response.statusCode,           // is statusCode 2XX
                error == nil                                  // was there no error
                    
                else { return }
             
                do {
                    guard let pokemon = try? JSONDecoder().decode(DetailPokemon.self, from: data) else { return }
                    
                    for pok in pokemon.abilities {
                        let name = pok.ability
                        print("NameDetail: \(name)")
                    }

                    completion(pokemon)
                }

            }.resume()
        }
    
        
    }
    
//

