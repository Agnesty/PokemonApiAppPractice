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
    var detailVC : DetailViewController?
    
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
            print("pokemonFavorites count: \(self.pokemonFavorites.count)")
            self.pokemonFavorites.forEach { favorite in
                print("species: \(favorite.speciesPoke)")
            }
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
    
    //Fungsi untuk di Delete
    func handleMoveToTrash(indexPath: IndexPath) {
        let pokemon = pokemonFavorites[indexPath.row]
        coredataManager.delete(pokemon.speciesPoke) {
            DispatchQueue.main.async { [weak self] in
                self?.pokemonFavorites.remove(at: indexPath.row)
                self?.tableFavorite.deleteRows(at: [indexPath], with: .fade)
            }
        }
        let isFavorite = coredataManager.isFavorite(pokemon.speciesPoke)
        let favoriteImage = isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
            detailVC?.favoriteButton.setImage(favoriteImage, for: .normal)
        print("Moved to trash")
    }
    
    //Fungsi untuk di Edit
    private func handleMarkAsEdit(indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "EditData", bundle: nil)
        guard let displayEdit = storyboard.instantiateViewController(withIdentifier: "EditDataViewController") as? EditDataViewController else { return }
        
        let pokemon = pokemonFavorites[indexPath.row]
        displayEdit.modelsIndex = pokemon
        print("Marked as edit")
        
        self.navigationController?.pushViewController(displayEdit, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        //TRASH
        let trash = UIContextualAction(style: .destructive,
                                       title: nil) { [weak self] (action, view, completionHandler) in
            self?.handleMoveToTrash(indexPath: indexPath)
            completionHandler(true)
        }
        trash.image = UIImage(systemName: "trash")
        trash.backgroundColor = .systemRed
        
        //EDIT
        let edit = UIContextualAction(style: .destructive,
                                       title: nil) { [weak self] (action, view, completionHandler) in
            self?.handleMarkAsEdit(indexPath: indexPath)
            completionHandler(true)
            
        }
        edit.image = UIImage(systemName: "pencil")
        edit.backgroundColor = .systemGreen
        let configuration = UISwipeActionsConfiguration(actions: [trash, edit])

        return configuration
    }
    
    
    
    
}

