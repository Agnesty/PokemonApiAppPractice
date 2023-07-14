//
//  BaseStatsViewController.swift
//  PokemonCRUD
//
//  Created by Agnes Triselia Yudia on 14/07/23.
//

import UIKit

var urlBase = ""

class BaseStatsViewController: UIViewController {

    @IBOutlet weak var progressView: UIProgressView!
    
    func sendConfigurationURLToBaseStats(_ data: String) {
        urlBase = data
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progressView.progress = Float(10)/100
        // Do any additional setup after loading the view.
    }
    


}
