//
//  CollectionCellController.swift
//  PokemonCRUD
//
//  Created by Agnes Triselia Yudia on 12/07/23.
//

import UIKit

class CollectionController: UIViewController {
    var pokemonList = [SpecificPokemon]()
    var myPokemonManager = PokemonManager()
    
    var pokeData: [DetailPokemon] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CollectionViewCell.nib(), forCellWithReuseIdentifier: CollectionViewCell.identifier)
        
        myPokemonManager.fetchDataFromAPI { pokemon in
            self.pokemonList.append(contentsOf: pokemon.results)
        }
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
}

extension CollectionController: UICollectionViewDelegate {
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            if collectionView.cellForItem(at: indexPath) is CollectionViewCell {
                let selectedObject = pokemonList[indexPath.row]
                let storyboard = UIStoryboard(name: "DetailView", bundle: nil)
                guard let displayDetail = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
                
                let storyboardPars = UIStoryboard(name: "DetailView", bundle: nil)
                guard let about = storyboardPars.instantiateViewController(withIdentifier: "AboutViewController") as? AboutViewController else { return }
                guard let baseStats = storyboardPars.instantiateViewController(withIdentifier: "BaseStatsViewController") as? BaseStatsViewController else { return }
                guard let moves = storyboardPars.instantiateViewController(withIdentifier: "MoveViewController") as? MoveViewController else { return }
                about.sendConfigurationURLToAbout(selectedObject.url)
                baseStats.sendConfigurationURLToBaseStats(selectedObject.url)
                moves.sendConfigurationURLToMoves(selectedObject.url)
                
                //Membuat Navigation Title dengan Font pilihan
//                let pokemonName = pokemonList[indexPath.row].name.uppercased()
//                let attributes: [NSAttributedString.Key: Any] = [
//                    .font: UIFont(name: "Noteworthy", size: 20)!,
//                ]
//
//                let attributedTitle = NSAttributedString(string: pokemonName, attributes: attributes)
//
//                displayDetail.navigationItem.title = attributedTitle.string
                
                //Mengirimkan data URL ke DetailPage
                displayDetail.url = pokemonList[indexPath.row].url
                self.navigationController?.pushViewController(displayDetail, animated: true)
            }
            print("You tapped me")
        }
}

extension CollectionController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemonList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell
        else {
            return UICollectionViewCell()
        }
        
        let pokemon = pokemonList[indexPath.row]
        let imageString = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(indexPath.item + 1).png"
        
        if let imgaeUrl = URL(string: imageString) {
            DispatchQueue.global().async {
                if let imageData = try? Data(contentsOf: imgaeUrl),
                   let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        if collectionView.indexPath(for: cell) == indexPath {
                            cell.image.image = image
                        }
                    }
                }
            }
        }
        
        let name = pokemon.name

        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Noteworthy-Bold", size: 14)!,
            .foregroundColor: UIColor.black
        ]

        let attributedText = NSAttributedString(string: name.uppercased(), attributes: attributes)
        cell.name.attributedText = attributedText
        
        let color = UIColor(red: 1.0, green: 0.8, blue: 0.0, alpha: 0.7)
        cell.backgroundColor = color.withAlphaComponent(0.7)
        
                return cell
    }
}

extension CollectionController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 100)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}
