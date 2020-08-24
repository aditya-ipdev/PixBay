//
//  LocalDatabase.swift
//  Markets_CoreData
//
//  Created by Darshan Mothreja on 10/07/20.
//

import UIKit
import CoreData



class LocalDatabase {
    
    var appDelegate: AppDelegate! = (UIApplication.shared.delegate as! AppDelegate)
    
    struct LocalDBRef {
        static var dbList: [UserSearchedContent] = []
    }
  
    enum Entity: String, CaseIterable {
        case UserSearchedContent
    }
    
    var persistentContainer: NSPersistentContainer {
        return appDelegate.persistentContainer
    }
    
    func saveContext() {
        do {
            appDelegate.loadLocalDB()
            try persistentContainer.viewContext.save()
        }catch let error {
            print(error)
        }
    }
    
     func saveToEntity(name: String) -> NSEntityDescription {
        let entity = NSEntityDescription.entity(forEntityName: name, in: persistentContainer.viewContext)
        return entity!
    }
    
    // MARK: Save Coredata Model
    func save<T: NSManagedObject>(modal: T,entity: Entity) {
        
        let entityDescription = self.saveToEntity(name: entity.rawValue)
        _ = T(entity: entityDescription, insertInto: persistentContainer.viewContext)
        saveContext()
    }
    
    
    // MARK: Fetch Record
    func fetch(with entity: Entity, predict: NSPredicate? = nil) -> [Any] {
        let managedObjectContext = persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity.rawValue)
        request.returnsObjectsAsFaults = false
        do {
            let result = try managedObjectContext.fetch(request)
            for data in result as! [NSManagedObject] {
               print(data.value(forKey: "searchedKeyword") as! String)
          }
            return result
            
        } catch {
            
            print("Failed")
        }
        return []
    }
    
    // MARK: Delete Entity
    func deleteEntity(with name: Entity) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: name.rawValue)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try self.persistentContainer.persistentStoreCoordinator.execute(deleteRequest, with: self.persistentContainer.viewContext)
        } catch let error {
            print("Unable to delete entity === ", error)
        }
    }
    
    // Clear Storage
    private func clearStorage(entities: [Entity]) {
        entities.forEach { (entity) in
            self.deleteEntity(with: entity)
        }
    }
    
}


