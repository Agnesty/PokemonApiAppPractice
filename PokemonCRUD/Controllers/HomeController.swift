//
//  ViewController.swift
//  PokemonCRUD
//
//  Created by Agnes Triselia Yudia on 12/07/23.
//

import UIKit

class HomeController: UIViewController {
    let pokemonList = [SpecificPokemon]()
    
    let myPokemonManager = PokemonManager()
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(UINib(nibName: "PokemonCell", bundle: nil), forCellReuseIdentifier: "pokemoncell")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myPokemonManager.fetchDataFromAPI()
    }


}

extension HomeController: UITableViewDelegate, UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("jumlah : \(pokemonList.count)")
        return pokemonList.count
        
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "pokemoncell", for: indexPath) as? PokemonCell else {
            return UITableViewCell()
        }

        let pokemon = pokemonList[indexPath.row]
        
        cell.labelName.text = pokemon.name
        cell.labelURL.text = pokemon.url
        
                return cell
       
    }
}

