//
//  DetailViewController.swift
//  PokemonCRUD
//
//  Created by Agnes Triselia Yudia on 12/07/23.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    private var url: String = ""
    private let detailViewModel = DetailViewModel()
    
    func setUrlString(url: String) {
        self.url = url
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = true
        self.view.bringSubviewToFront(aboutSegementView)
        
        detailViewModel.detailViewController = self
        detailViewModel.getDetailCoba(abilitiesUrl: url)
        
//        detailViewModel.getDetail(abilitiesUrl: url) { detailPokemon in
//            DispatchQueue.main.async { [weak self] in
//                guard let unwrappedSelf = self else { return }
//                unwrappedSelf.id.text = "#\(detailPokemon.id)"
//
//                //Load Image
//                guard let urlImage = URL(string: (detailPokemon.sprites.frontDefault)) else { return }
//                unwrappedSelf.image.sd_setImage(with: urlImage)
//            }
//        }
    }
    
    @IBOutlet weak var moveSegmentView: UIView!
    @IBOutlet weak var aboutSegementView: UIView!
    @IBOutlet weak var baseStatsSegmentView: UIView!
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
        
        detailViewModel.createCoreData()
        favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        
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
