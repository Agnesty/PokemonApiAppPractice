//
//  FavoriteViewController.swift
//  PokemonCRUD
//
//  Created by Agnes Triselia Yudia on 17/07/23.
//

import UIKit

class FavoriteViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var pokemonFavorites: [Favorite] = []
    var coredataManager = CoreDataManager()
    
    @IBOutlet weak var tableFavorite: UITableView! {
        didSet {
            tableFavorite.dataSource = self
            tableFavorite.delegate = self
            tableFavorite.register(UINib(nibName: "FavoriteViewCell", bundle: nil), forCellReuseIdentifier: "favoritecell")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        coredataManager.retreive() = pokemonFavorites
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        coredataManager.retrieve { favorites in
            self.pokemonFavorites = favorites
            print(self.pokemonFavorites.count)
            DispatchQueue.main.async {
                self.tableFavorite.reloadData()
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("jumlah : \(pokemonFavorites.count)")
        return pokemonFavorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoritecell", for: indexPath) as? FavoriteViewCell else {
            return UITableViewCell()
        }
        
        let pokemon = pokemonFavorites[indexPath.row]
        
        cell.speciesLabel.text = pokemon.speciesPoke
        cell.abilityLabel.text = pokemon.abilityPoke
        cell.typesLabel.text = pokemon.typePoke
        cell.setImageWithPlugin(url: pokemon.imagePoke)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func handleMoveToTrash(indexPath: IndexPath) {
        let pokemon = pokemonFavorites[indexPath.row]
        coredataManager.delete(pokemon.speciesPoke) {
            DispatchQueue.main.async { [weak self] in
                self?.pokemonFavorites.remove(at: indexPath.row)
                self?.tableFavorite.deleteRows(at: [indexPath], with: .fade)
            }
        }
        
        print("Moved to trash")
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let trash = UIContextualAction(style: .destructive,
                                       title: "Trash") { [weak self] (action, view, completionHandler) in
            self?.handleMoveToTrash(indexPath: indexPath)
            completionHandler(true)
        }
        trash.backgroundColor = .systemRed
        let configuration = UISwipeActionsConfiguration(actions: [trash])

        return configuration
    }
    
    
    
    
}

