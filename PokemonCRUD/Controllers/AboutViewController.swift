//
//  AboutViewController.swift
//  PokemonCRUD
//
//  Created by Agnes Triselia Yudia on 14/07/23.
//

import UIKit

var urlAbout = ""

class AboutViewController: UIViewController {
    private let aboutViewModel = AboutViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aboutViewModel.aboutViewController = self
        aboutViewModel.getDetailAbout(urlAbout: urlAbout)
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var isiSpesies: UILabel!
    @IBOutlet weak var isiHeight: UILabel!
    @IBOutlet weak var isiWeight: UILabel!
    @IBOutlet weak var isiAbility: UILabel!
    @IBOutlet weak var isiTypes: UILabel!
}

extension AboutViewController: PokemonAboutDelegate {
    func sendConfigurationURLToAbout(_ data: String) {
        urlAbout = data
    }
}
