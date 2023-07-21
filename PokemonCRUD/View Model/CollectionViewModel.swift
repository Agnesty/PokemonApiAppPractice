//
//  CollectionViewModel.swift
//  PokemonCRUD
//
//  Created by Agnes Triselia Yudia on 20/07/23.
//

import Foundation
import UIKit

class CollectionViewModel {
    var collectionViewController: CollectionController?
    
    var pokemonList = [SpecificPokemon]()
    var myPokemonManager = PokemonManager()
    
    func getDataCollection() {
        guard let unwrappedVC = collectionViewController else {
            return
        }
        
        myPokemonManager.fetchDataFromAPI { pokemon in
            self.pokemonList.append(contentsOf: pokemon.results)
            DispatchQueue.main.async {
                unwrappedVC.collectionView.reloadData()
            }
            
        }
    }
    //Belum Ada
}
