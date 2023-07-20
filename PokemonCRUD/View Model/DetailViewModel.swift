//
//  DetailViewModel.swift
//  PokemonCRUD
//
//  Created by Agnes Triselia Yudia on 20/07/23.
//

import Foundation

class DetailViewModel {
   
    var ability: [Ability] = []
    var detailPokemon: DetailPokemon?
    var coredataManager = CoreDataManager()
    var detailViewController: DetailViewController?
    
    func getDetail(abilitiesUrl: String, completion: @escaping ((DetailPokemon) -> Void)) {
        PokemonManager().getDetail(abilitiesURL: abilitiesUrl) { detailPokemon in
            completion(detailPokemon)
        }
    }
    
    func getDetailCoba(abilitiesUrl: String) {
        PokemonManager().getDetail(abilitiesURL: abilitiesUrl) { detailPokemon in
            self.detailPokemon = detailPokemon
            print("sprites \(String(describing: self.detailPokemon?.sprites))")
            
            DispatchQueue.main.async { [self] in
                //Unwrapped ViewController
                guard let unwrappedVC = detailViewController else { return }
                
                //ID
                guard let id = self.detailPokemon?.id else {
                    unwrappedVC.id.text = ""
                    return
                }
                unwrappedVC.id.text = String("#\(id)")
                
                //Load Image
                guard let urlImage = URL(string: (self.detailPokemon?.sprites.frontDefault)!) else { return }
                unwrappedVC.image.sd_setImage(with: urlImage)
                
            }
            
        }
    }
    
    func createCoreData() {
        //Isi Image
        guard let urlImage = self.detailPokemon?.sprites.frontDefault else { return }
        
        //Isi Species
        guard let species = self.detailPokemon?.species.name.capitalized else { return }
        
        //Isi Ability
        guard let ability = self.detailPokemon?
            .abilities.map({$0.ability.name.capitalized}).joined(separator: ", ") else { return }

        //Isi Types
        guard let types = self.detailPokemon?
            .types.map({$0.type.name.capitalized}).joined(separator: ", ") else { return }
        
        coredataManager.create(species, types, ability, urlImage)
        
    }
}
