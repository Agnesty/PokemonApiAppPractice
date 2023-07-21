//
//  CollectionViewModel.swift
//  PokemonCRUD
//
//  Created by Agnes Triselia Yudia on 20/07/23.
//

import Foundation
import UIKit

class CollectionViewModel {
    
    var pokemonList = [SpecificPokemon]()
    var myPokemonManager = PokemonManager()
    
    func getDataCollection() {
        myPokemonManager.fetchDataFromAPI { pokemon in
            self.pokemonList.append(contentsOf: pokemon.results)
        }
    }
    //Belum Ada
}
