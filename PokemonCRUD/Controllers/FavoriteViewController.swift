//
//  FavoriteViewController.swift
//  PokemonCRUD
//
//  Created by Agnes Triselia Yudia on 17/07/23.
//

import UIKit

class FavoriteViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    private let favoriteViewModel = FavoriteViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteViewModel.favoriteVC = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favoriteViewModel.retrieveCoreDataFavorite()
    }
    
    @IBOutlet weak var tableFavorite: UITableView! {
        didSet {
            tableFavorite.dataSource = self
            tableFavorite.delegate = self
            tableFavorite.register(UINib(nibName: "FavoriteViewCell", bundle: nil), forCellReuseIdentifier: "favoritecell")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("jumlah : \(favoriteViewModel.pokemonFavoritesCount())")
        return favoriteViewModel.pokemonFavoritesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoritecell", for: indexPath) as? FavoriteViewCell else {
            return UITableViewCell()
        }
        
        let pokemon = favoriteViewModel.pokemonFavorites[indexPath.row]
        
        cell.speciesLabel.text = pokemon.speciesPoke
        cell.abilityLabel.text = pokemon.abilityPoke
        cell.typesLabel.text = pokemon.typePoke
        cell.setImageWithPlugin(url: pokemon.imagePoke)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        //TRASH
        let trash = UIContextualAction(style: .destructive,
                                       title: nil) { [weak self] (action, view, completionHandler) in
            self?.favoriteViewModel.handleMoveToTrash(indexPath: indexPath)
            completionHandler(true)
        }
        trash.image = UIImage(systemName: "trash")
        trash.backgroundColor = .systemRed
        
        //EDIT
        let edit = UIContextualAction(style: .destructive,
                                       title: nil) { [weak self] (action, view, completionHandler) in
            self?.favoriteViewModel.handleMarkAsEdit(indexPath: indexPath)
            completionHandler(true)
            
        }
        edit.image = UIImage(systemName: "pencil")
        edit.backgroundColor = .systemGreen
        let configuration = UISwipeActionsConfiguration(actions: [trash, edit])

        return configuration
    }
    
    
    
    
}

