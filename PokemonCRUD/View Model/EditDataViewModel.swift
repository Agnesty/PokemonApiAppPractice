//
//  EditDataViewModel.swift
//  PokemonCRUD
//
//  Created by Agnes Triselia Yudia on 20/07/23.
//

import Foundation
import UIKit

class EditDataViewModel {
    var editViewController: EditDataViewController?
    private let coreDataManager = CoreDataManager()
    
    func willAppear() {
        guard let unwrappedVC = editViewController else { return }
        unwrappedVC.speciesTF.text = unwrappedVC.modelsIndex?.speciesPoke
        unwrappedVC.abilitiesTF.text = unwrappedVC.modelsIndex?.abilityPoke
        unwrappedVC.typesTF.text = unwrappedVC.modelsIndex?.typePoke
    }
    
    func updateCoreData() {
        guard let unwrappedVC = editViewController else { return }
        guard let species = unwrappedVC.speciesTF.text else { return }
        guard let ability = unwrappedVC.abilitiesTF.text else {
            return
        }
        guard let types = unwrappedVC.typesTF.text else {
            return
        }
        
        coreDataManager.updateData(speci: unwrappedVC.modelsIndex!.speciesPoke, with: species, namaDatadiCoreData: "speciesPoke")
        coreDataManager.updateData(speci: unwrappedVC.modelsIndex!.abilityPoke, with: ability, namaDatadiCoreData: "abilityPoke")
        coreDataManager.updateData(speci: unwrappedVC.modelsIndex!.typePoke, with: types, namaDatadiCoreData: "typePoke")
    }
    
    func showAlert() {
        guard let unwrappedVC = editViewController else { return }
        let alert = UIAlertController(title: "Data Updated", message: "Data has been successfully updated.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            
            // Kembali ke halaman sebelumnya
            unwrappedVC.navigationController?.popViewController(animated: true)
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
