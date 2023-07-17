//
//  FavoriteViewCell.swift
//  PokemonCRUD
//
//  Created by Agnes Triselia Yudia on 17/07/23.
//

import UIKit
import SDWebImage

class FavoriteViewCell: UITableViewCell {

    @IBOutlet weak var imageFavorite: UIImageView!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var abilityLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setImageWithPlugin(url: String) {
        
        let urlImage = URL(string: url)
        imageFavorite.sd_setImage(with: urlImage)
    }
    
}
