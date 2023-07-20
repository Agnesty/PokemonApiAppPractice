//
//  PokemonViewModel.swift
//  PokemonCRUD
//
//  Created by Agnes Triselia Yudia on 18/07/23.
//

import Foundation


class HomeViewModel {
    var pokemonListing = [SpecificPokemon]()
    var myPokemonManager = PokemonManager()
    
    var homeViewController: HomeController?
    
    func fetchDataFromApi() {
        //Unwrapped ViewController
        guard let unwrappedVC = homeViewController else { return }
        myPokemonManager.fetchDataFromAPI { pokemon in
            self.pokemonListing.append(contentsOf: pokemon.results)
            DispatchQueue.main.async {
                unwrappedVC.tableView.reloadData()
            }
        }
    }
    
}
