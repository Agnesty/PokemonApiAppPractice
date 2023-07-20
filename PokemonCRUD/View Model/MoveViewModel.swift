//
//  MoveViewModel.swift
//  PokemonCRUD
//
//  Created by Agnes Triselia Yudia on 20/07/23.
//

import Foundation

protocol PokemonMoveDelegate: AnyObject {
    func sendConfigurationURLToMoves(_ data: String)
}

class MoveViewModel {
    var detailPokemon: DetailPokemon?
    var pokemonManager = PokemonManager()
    var moveViewController: MoveViewController?
    weak var delegate: PokemonMoveDelegate?
    
    func getDetailMoves(urlMoves: String) {
        guard let unwrapped = moveViewController else { return }
        
        pokemonManager.getDetail(abilitiesURL: urlMoves) { detailPokemon in
            self.detailPokemon = detailPokemon
            print("sprites upupupuupu \(String(describing: self.detailPokemon?.moves[0].move.name))")
            
            DispatchQueue.main.async {
                unwrapped.tableViewMove.reloadData()
            }
        }
    }
}
