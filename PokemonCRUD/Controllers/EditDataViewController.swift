//
//  EditDataViewController.swift
//  PokemonCRUD
//
//  Created by Agnes Triselia Yudia on 18/07/23.
//

import UIKit

class EditDataViewController: UIViewController {
    
    var modelsIndex: Favorite?
    private let editDataViewModel = EditDataViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("EditDataVC species: \(modelsIndex!.speciesPoke)")
        editDataViewModel.editViewController = self
        editDataViewModel.willAppear()
    }
    override func viewWillAppear(_ animated: Bool) {
        editDataViewModel.willAppear()
    }
    
    @IBOutlet weak var speciesTF: UITextField!
    @IBOutlet weak var abilitiesTF: UITextField!
    @IBOutlet weak var typesTF: UITextField!
    @IBAction func buttonDone(_ sender: UIButton) {
        editDataViewModel.updateCoreData()
        editDataViewModel.showAlert()
    }

}
