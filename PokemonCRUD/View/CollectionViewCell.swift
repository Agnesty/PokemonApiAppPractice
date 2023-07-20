//
//  CollectionViewCell.swift
//  PokemonCRUD
//
//  Created by Agnes Triselia Yudia on 12/07/23.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CollectionViewCell"
    
    @IBOutlet weak var image: UIImageView! {
        didSet {
            let scaleFactor: CGFloat = 1.3
            image.transform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)
        }
    }
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var view: UIView! {
        didSet {
            view.layer.cornerRadius = CGFloat(15)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true
        // Initialization code
    }
    static func nib() -> UINib {
        return UINib(nibName: "CollectionViewCell", bundle: nil)
    }

}
