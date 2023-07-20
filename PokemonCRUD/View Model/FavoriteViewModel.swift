//
//  FavoriteViewModel.swift
//  PokemonCRUD
//
//  Created by Agnes Triselia Yudia on 20/07/23.
//

import Foundation
import UIKit

class FavoriteViewModel {
    
    var pokemonFavorites: [Favorite] = []
    var coredataManager = CoreDataManager()
    var detailVC : DetailViewController?
    var favoriteVC: FavoriteViewController?
    
    func pokemonFavoritesCount() -> Int {
        return pokemonFavorites.count
    }
    
    func retrieveCoreDataFavorite() {
        guard let unwrappedFavoriteVC = favoriteVC else { return }
        
        coredataManager.retrieve { favorites in
            self.pokemonFavorites = favorites
            print("pokemonFavorites count: \(self.pokemonFavorites.count)")
            self.pokemonFavorites.forEach { favorite in
                print("species: \(favorite.speciesPoke)")
            }
            print(self.pokemonFavorites.count)
            DispatchQueue.main.async {
                print("reload")
                unwrappedFavoriteVC.tableFavorite.reloadData()
            }
        }
    }
    
    //Fungsi untuk di Delete
    func handleMoveToTrash(indexPath: IndexPath) {
        guard let unwrappedFavoriteVC = favoriteVC else { return }
        let pokemon = pokemonFavorites[indexPath.row]
        coredataManager.delete(pokemon.speciesPoke) {
            DispatchQueue.main.async { [weak self] in
                self?.pokemonFavorites.remove(at: indexPath.row)
                unwrappedFavoriteVC.tableFavorite.deleteRows(at: [indexPath], with: .fade)
            }
        }
        let isFavorite = coredataManager.isFavorite(pokemon.speciesPoke)
        let favoriteImage = isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
            detailVC?.favoriteButton.setImage(favoriteImage, for: .normal)
        print("Moved to trash")
    }
    
    //Fungsi untuk di Edit
    func handleMarkAsEdit(indexPath: IndexPath) {
        guard let unwrappedFavoriteVC = favoriteVC else { return }
        let storyboard = UIStoryboard(name: "EditData", bundle: nil)
        guard let displayEdit = storyboard.instantiateViewController(withIdentifier: "EditDataViewController") as? EditDataViewController else { return }
        
        let pokemon = pokemonFavorites[indexPath.row]
        displayEdit.modelsIndex = pokemon
        print("Marked as edit")
        
        unwrappedFavoriteVC.navigationController?.pushViewController(displayEdit, animated: true)
    }
    
    
}
