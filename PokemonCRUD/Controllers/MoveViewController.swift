//
//  MoveViewController.swift
//  PokemonCRUD
//
//  Created by Agnes Triselia Yudia on 14/07/23.
//

import UIKit

var urlMoves = ""

class MoveViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableViewMove: UITableView! {
        didSet{
            tableViewMove.dataSource = self
            tableViewMove.delegate = self
            tableViewMove.register(UINib(nibName: "MoveTableViewCell", bundle: nil), forCellReuseIdentifier: "movecell")
        }
    }
    
    var detailPokemon: DetailPokemon?
    
    func sendConfigurationURLToMoves(_ data: String) {
        urlMoves = data
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let pokeDetail = detailPokemon else { return 0 }
        return pokeDetail.moves.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movecell", for: indexPath) as? MoveTableViewCell else {
            print("data table kosong")
            return UITableViewCell()
        }

        let pokemon = detailPokemon?.moves[indexPath.row]
        cell.namaMove.text = pokemon?.move.name
        
                return cell
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    override func viewDidLoad() {
        super.viewDidLoad() 
        
        PokemonManager().getDetail(abilitiesURL: urlMoves) { detailPokemon in
            self.detailPokemon = detailPokemon
            print("sprites upupupuupu \(String(describing: self.detailPokemon?.moves[0].move.name))")
            
            DispatchQueue.main.async {
                self.tableViewMove.reloadData()
            }
        }

    }
    
//    func reloadTableView() {
//        DispatchQueue.main.async { [weak self] in
//            guard let unwrappedSelf = self else {
//                print("self is nil")
//                return
//            }
//            guard let detailPokemon = unwrappedSelf.detailPokemon else {
//                print("detail pokemon is nil")
//                return
//            }
//            unwrappedSelf.tableViewMove.reloadData()
//            print("reload table view, jumlah: \(detailPokemon.moves.count)")
//        }
//    }
    

}
