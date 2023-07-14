//
//  AboutViewController.swift
//  PokemonCRUD
//
//  Created by Agnes Triselia Yudia on 14/07/23.
//

import UIKit

var urlAbout = ""

class AboutViewController: UIViewController {
    
    var detailPokemon: DetailPokemon?
    
    func sendConfigurationURLToAbout(_ data: String) {
        urlAbout = data
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        PokemonManager().getDetail(abilitiesURL: urlAbout) { detailPokemon in
            self.detailPokemon = detailPokemon
            print("sprites \(String(describing: self.detailPokemon?.sprites))")

            DispatchQueue.main.async {
                //Label Name
                guard let namaPokemon = self.detailPokemon?.species.name.capitalized else {
                    self.labelName.text = ""
                    return
                }
                self.labelName.text = namaPokemon

                //Isi Species
                guard let species = self.detailPokemon?.species.name.capitalized else {
                    self.isiSpesies.text = ""
                    return
                }
                self.isiSpesies.text = species

                //Isi Height
                guard let height = self.detailPokemon?.height else {
                    self.isiHeight.text = ""
                    return
                }
                self.isiHeight.text = String(height)

                //Isi Weight
                guard let weight = self.detailPokemon?.weight else {
                    self.isiWeight.text = ""
                    return
                }
                self.isiWeight.text = String(weight)

                //Isi Ability
                self.isiAbility.text = self.detailPokemon?
                    .abilities.map({$0.ability.name.capitalized}).joined(separator: ", ")

                //Isi Types
                self.isiTypes.text = self.detailPokemon?
                    .types.map({$0.type.name.capitalized}).joined(separator: ", ")

            }

        }
        
        
        
        
        

        // Do any additional setup after loading the view.
    }
   
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var isiSpesies: UILabel!
    @IBOutlet weak var isiHeight: UILabel!
    @IBOutlet weak var isiWeight: UILabel!
    @IBOutlet weak var isiAbility: UILabel!
    @IBOutlet weak var isiTypes: UILabel!
    
}
