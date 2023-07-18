//
//  EditDataViewController.swift
//  PokemonCRUD
//
//  Created by Agnes Triselia Yudia on 18/07/23.
//

import UIKit

class EditDataViewController: UIViewController {
    
    var modelsIndex: Favorite?
    
    @IBOutlet weak var speciesTF: UITextField!
    @IBOutlet weak var abilitiesTF: UITextField!
    @IBOutlet weak var typesTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("EditDataVC species: \(modelsIndex!.speciesPoke)")
        speciesTF.text = modelsIndex?.speciesPoke
        abilitiesTF.text = modelsIndex?.abilityPoke
        typesTF.text = modelsIndex?.typePoke

        // Do any additional setup after loading the view.
    }
  
    
    override func viewWillAppear(_ animated: Bool) {
        speciesTF.text = modelsIndex?.speciesPoke
        abilitiesTF.text = modelsIndex?.abilityPoke
        typesTF.text = modelsIndex?.typePoke
    }
    
    @IBAction func buttonDone(_ sender: UIButton) {
        guard let species = speciesTF.text else { return }
        guard let ability = abilitiesTF.text else {
            return
        }
        guard let types = typesTF.text else {
            return
        }
        
        CoreDataManager().updateData(speci: modelsIndex!.speciesPoke, with: species, namaDatadiCoreData: "speciesPoke")
        CoreDataManager().updateData(speci: modelsIndex!.abilityPoke, with: ability, namaDatadiCoreData: "abilityPoke")
        CoreDataManager().updateData(speci: modelsIndex!.typePoke, with: types, namaDatadiCoreData: "typePoke")
        
        showAlert()
        
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Data Updated", message: "Data has been successfully updated.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] (_) in
            
            // Kembali ke halaman sebelumnya
            self?.navigationController?.popViewController(animated: true)
        }
        alert.addAction(okAction)

        // Present the alert
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first(where: { $0.isKeyWindow }) else { return }
        if let viewController = window.rootViewController {
            viewController.present(alert, animated: true, completion: nil)
        }
    }



}
