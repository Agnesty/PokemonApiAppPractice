//
//  AboutViewModel.swift
//  PokemonCRUD
//
//  Created by Agnes Triselia Yudia on 20/07/23.
//

import Foundation

protocol PokemonAboutDelegate: AnyObject {
    func sendConfigurationURLToAbout(_ data: String)
}

class AboutViewModel {
    var pokemonManager = PokemonManager()
    var detailPokemon: DetailPokemon?
    var aboutViewController: AboutViewController?
    weak var delegate: PokemonAboutDelegate?
    
    func getDetailAbout(urlAbout: String) {
        
        guard let unwrappedVC = aboutViewController else { return }
        pokemonManager.getDetail(abilitiesURL: urlAbout) { detailPokemon in
            self.detailPokemon = detailPokemon
            print("sprites \(String(describing: self.detailPokemon?.sprites))")
            
            DispatchQueue.main.async {
                //Label Name
                guard let namaPokemon = self.detailPokemon?.species.name.capitalized else {
                    unwrappedVC.labelName.text = ""
                    return
                }
                unwrappedVC.labelName.text = namaPokemon
                
                //Isi Species
                guard let species = self.detailPokemon?.species.name.capitalized else {
                    unwrappedVC.isiSpesies.text = ""
                    return
                }
                unwrappedVC.isiSpesies.text = species
                
                //Isi Height
                guard let height = self.detailPokemon?.height else {
                    unwrappedVC.isiHeight.text = ""
                    return
                }
                unwrappedVC.isiHeight.text = String(height)
                
                //Isi Weight
                guard let weight = self.detailPokemon?.weight else {
                    unwrappedVC.isiWeight.text = ""
                    return
                }
                unwrappedVC.isiWeight.text = String(weight)
                
                //Isi Ability
                unwrappedVC.isiAbility.text = self.detailPokemon?
                    .abilities.map({$0.ability.name.capitalized}).joined(separator: ", ")
                
                //Isi Types
                unwrappedVC.isiTypes.text = self.detailPokemon?
                    .types.map({$0.type.name.capitalized}).joined(separator: ", ")
                
            }
            
        }
    }
}
