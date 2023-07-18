//
//  CoreDataManager.swift
//  PokemonCRUD
//
//  Created by Agnes Triselia Yudia on 17/07/23.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager: UIViewController {
    //referensi ke AppDelegate
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    //Create Data for Favorite
//     func create(_ speciesPoke: String, _ typePoke: String, _ abilityPoke: String, _ imagePoke: String) {
//
//        //managed context
//        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
//
//        //referensi entity yang telah dibuat sebelumnya
//        let userEntity = NSEntityDescription.entity(forEntityName: "FavoritePokemon", in: managedContext)
//
//        //entity body
//        let insert = NSManagedObject(entity: userEntity!, insertInto: managedContext)
//        insert.setValue(speciesPoke, forKey: "speciesPoke")
//        insert.setValue(typePoke, forKey: "typePoke")
//        insert.setValue(abilityPoke, forKey: "abilityPoke")
//        insert.setValue(imagePoke, forKey: "imagePoke")
//
//        do {
//            try managedContext.save()
//            print("Saved data into CoreData")
//        } catch let error {
//            print("Failed to saved Data", error)
//        }
//    }
    
    func create(_ speciesPoke: String, _ typePoke: String, _ abilityPoke: String, _ imagePoke: String, completion: (() -> Void)? = nil) {
        //managed context
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoritePokemon")
        fetchRequest.predicate = NSPredicate(format: "speciesPoke = %@", speciesPoke)
        
        func showAlert() {
            let alert = UIAlertController(title: "Data Created", message: "Data has been successfully created.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }

        do {
            let result = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if result?.isEmpty == true {
                // Data tidak ditemukan, tambahkan ke Core Data
                let userEntity = NSEntityDescription.entity(forEntityName: "FavoritePokemon", in: managedContext)

                //entity body
                let insert = NSManagedObject(entity: userEntity!, insertInto: managedContext)
                insert.setValue(speciesPoke, forKey: "speciesPoke")
                insert.setValue(typePoke, forKey: "typePoke")
                insert.setValue(abilityPoke, forKey: "abilityPoke")
                insert.setValue(imagePoke, forKey: "imagePoke")

                try managedContext.save()
                print("Saved data into CoreData")
                showAlert()
                completion?() // Panggil closure penanganan setelah penyimpanan berhasil
            } else {
                // Data sudah ada, tampilkan pesan bahwa data sudah ada sebelumnya
                let alert = UIAlertController(title: "Data Already Exists", message: "Data with species \(speciesPoke) already exists in Core Data.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }
        } catch let error {
            print("Failed to fetch data", error)
        }
    }


    
    @discardableResult func retreive() -> [Favorite] {

        //Array Model
        var favorites = [Favorite]()

        //managed context
        let managedContext = appDelegate?.persistentContainer.viewContext

        //fetch data
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoritePokemon")

        do {
            let result = try managedContext?.fetch(fetchRequest) as! [NSManagedObject]

            result.forEach { favorite in
                favorites.append(
                    Favorite(
                        imagePoke: favorite.value(forKey: "imagePoke") as! String,
                        speciesPoke: favorite.value(forKey: "speciesPoke") as! String,
                        abilityPoke: favorite.value(forKey: "abilityPoke") as! String,
                        typePoke: favorite.value(forKey: "typePoke") as! String
                    )
                )
                print(favorites as Any)
            }
        } catch let error {
            print("Failed to catch data", error)
        }

        return favorites
    }
    
    func retrieve(completion: @escaping ([Favorite]) -> Void) {
        // Array Model
        var favorites = [Favorite]()

        // managed context
        let managedContext = appDelegate?.persistentContainer.viewContext

        // fetch data
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoritePokemon")

        do {
            guard let result = try managedContext?.fetch(fetchRequest) as? [NSManagedObject] else { return }

            result.forEach { favorite in
                favorites.append(
                    Favorite(
                        imagePoke: favorite.value(forKey: "imagePoke") as! String,
                        speciesPoke: favorite.value(forKey: "speciesPoke") as! String,
                        abilityPoke: favorite.value(forKey: "abilityPoke") as! String,
                        typePoke: favorite.value(forKey: "typePoke") as! String
                    )
                )
            }
            completion(favorites) // Panggil completion handler dengan data yang diambil
        } catch let error {
            print("Failed to catch data", error)
//            completion([]) // Panggil completion handler dengan array kosong jika terjadi kesalahan
        }
    }
    
    //MARK: DELETE DATA IN CORE DATA
    func delete(_ speciesPoke: String, completion: @escaping () -> Void) {

        //managed context
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {
            return }

        //fetch data to edit data
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "FavoritePokemon")
        fetchRequest.predicate = NSPredicate(format: "speciesPoke = %@", speciesPoke)

        do {
            let result = try managedContext.fetch(fetchRequest)

            for index in 0..<result.count {
                let dataToDelete = result[index] as! NSManagedObject
                managedContext.delete(dataToDelete)
            }
            try managedContext.save()
            completion()
//            retrieve()
            
        } catch let error {
            print("Unable to delete data", error)
        }
    }
    
    
    //MARK: CHECK APAKAH INI SUDAH DIFAVORITKAN ATAU BELUM
    func isFavorite(_ species: String) -> Bool {
        //managed context
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return false }

        //fetch data
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoritePokemon")
        fetchRequest.predicate = NSPredicate(format: "speciesPoke = %@", species)
        fetchRequest.fetchLimit = 1

        do {
            let count = try managedContext.count(for: fetchRequest)
            return count > 0
        } catch let error {
            print("Failed to fetch data", error)
            return false
        }
    }
    
    //MARK: UPDATE DATA EDIT POKEMON
    func updateData( speci: String, with newName: String, namaDatadiCoreData: String ) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }

        let managedContext = appDelegate.persistentContainer.viewContext

        let fetchRequest: NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: "FavoritePokemon")
            let modifiedPredicateFormat = "\(namaDatadiCoreData) = %@"
            fetchRequest.predicate = NSPredicate(format: modifiedPredicateFormat, speci)

        do {
          let fetchedResults = try managedContext.fetch(fetchRequest)

          if let pokemon = fetchedResults.first {
            pokemon.setValue(newName, forKey: namaDatadiCoreData)
              print("ini adalah hasil edit: \(newName)")

            do {
              try managedContext.save()
                retreive()
              print("Data updated successfully")
            } catch{
              print("Failed to update data: (error), (error.userInfo)", error)
            }
          }
        } catch {
          print("Fetch error: (error), (error.userInfo)", error)
        }
//        isChange = true
      }

    
}
