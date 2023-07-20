//
//  ViewController.swift
//  PokemonCRUD
//
//  Created by Agnes Triselia Yudia on 12/07/23.
//

import UIKit

class HomeController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private let homeViewModel = HomeViewModel()
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(UINib(nibName: "PokemonCell", bundle: nil), forCellReuseIdentifier: "pokemoncell")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeViewModel.homeViewController = self
        homeViewModel.fetchDataFromApi()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("jumlah : \(homeViewModel.pokemonListing.count)")
        return homeViewModel.pokemonListing.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "pokemoncell", for: indexPath) as? PokemonCell else {
            return UITableViewCell()
        }
        let pokemon = homeViewModel.pokemonListing[indexPath.row]
        cell.labelName.text = pokemon.name
        cell.labelURL.text = pokemon.url
                return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

}

