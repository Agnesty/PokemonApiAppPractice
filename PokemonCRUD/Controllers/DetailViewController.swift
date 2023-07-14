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
    
    @IBOutlet weak var moveSegmentView: UIView!
    @IBOutlet weak var aboutSegementView: UIView!
    @IBOutlet weak var baseStatsSegmentView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
