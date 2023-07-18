//
//  DetailViewController.swift
//  PokemonCRUD
//
//  Created by Agnes Triselia Yudia on 12/07/23.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    
    var url: String = ""
    var ability: [Ability] = []
    var detailPokemon: DetailPokemon?
    var coredataManager = CoreDataManager()
    
    @IBOutlet weak var moveSegmentView: UIView!
    @IBOutlet weak var aboutSegementView: UIView!
    @IBOutlet weak var baseStatsSegmentView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = true
        
        self.view.bringSubviewToFront(aboutSegementView)
        
        PokemonManager().getDetail(abilitiesURL: url) { detailPokemon in
            self.detailPokemon = detailPokemon
            print("sprites \(String(describing: self.detailPokemon?.sprites))")
            
            DispatchQueue.main.async {
                //ID
                guard let id = self.detailPokemon?.id else {
                    self.id.text = ""
                    return
                }
                self.id.text = String("#\(id)")
                
                //Load Image
                guard let urlImage = URL(string: (self.detailPokemon?.sprites.frontDefault)!) else { return }
                self.image.sd_setImage(with: urlImage)
                
//                guard let moveVC = self.storyboard?.instantiateViewController(identifier: "MoveViewController") as? MoveViewController else { return }
            }

        }
        
    }
    
    @IBOutlet weak var viewBackground: UIView! {
        didSet {
            viewBackground.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 35)
        }
    }
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var image: UIImageView! {
        didSet {
            let scaleFactor: CGFloat = 1.5
            image.transform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)
        }
    }
    
    @IBOutlet weak var favoriteButton: UIButton!
    @IBAction func favorite(_ sender: UIButton) {
        //Isi Image
        guard let urlImage = self.detailPokemon?.sprites.frontDefault else { return }
        
        //Isi Species
        guard let species = self.detailPokemon?.species.name.capitalized else { return }
        
        //Isi Ability
        guard let ability = self.detailPokemon?
            .abilities.map({$0.ability.name.capitalized}).joined(separator: ", ") else { return }

        //Isi Types
        guard let types = self.detailPokemon?
            .types.map({$0.type.name.capitalized}).joined(separator: ", ") else { return }
        
//        func showAlert() {
//            let alert = UIAlertController(title: "Data Created", message: "Data has been successfully created.", preferredStyle: .alert)
//            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//            alert.addAction(okAction)
//            present(alert, animated: true, completion: nil)
//        }
        
        coredataManager.create(species, types, ability, urlImage)
        favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
//        showAlert()
//        coredataManager.retreive()
//        coredataManager.retrieve()
    }
    
    @IBAction func segmentControlAction(_ sender: UISegmentedControl)
    {
        switch segmentControlOutlet.selectedSegmentIndex
        {
        case 0:
            self.view.bringSubviewToFront(aboutSegementView)
        case 1:
            self.view.bringSubviewToFront(baseStatsSegmentView)
        case 2:
            self.view.bringSubviewToFront(moveSegmentView)
        default:
            break
        }
    }
    @IBOutlet weak var segmentControlOutlet: UISegmentedControl!
    @IBOutlet weak var isiSpesies: UILabel!
    @IBOutlet weak var isiHeight: UILabel!
    @IBOutlet weak var isiWeight: UILabel!
    @IBOutlet weak var isiAbility: UILabel!
    @IBOutlet weak var isiTypes: UILabel!
    
   
    
}
