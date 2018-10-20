//
//  DataManager.swift
//  NasaSpaceApps2018
//
//  Created by Paloma Bispo on 20/10/18.
//  Copyright © 2018 Levy Cristian . All rights reserved.
//

import UIKit
import CoreData

class DataManager {

    static var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "NasaSpaceApps2018")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    static func saveContext () {
        let context = self.getContext()
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    static func getEntity(entity: String) -> (NSEntityDescription)?{
        let context = self.getContext()
        
        guard let description:NSEntityDescription = NSEntityDescription.entity(forEntityName: entity, in: context) else { return nil }
        
        return description
    }
    
    static func getContext () -> (NSManagedObjectContext) {
        return persistentContainer.viewContext
    }
    
    static func getAll(entity: NSEntityDescription) -> (success: Bool, objects: [NSManagedObject]){
        let context = self.getContext()
        
        let request:NSFetchRequest = NSFetchRequest<NSFetchRequestResult>()
        request.entity = entity
        
        var result:[NSManagedObject]?
        
        do {
            result = try context.fetch(request) as? [NSManagedObject]
            return(true, result!)
        } catch {
            print("Failed reading all")
            return(false, result!)
        }
    }
    
    static func deleteAll(entity: NSEntityDescription) {
        let managedContext = self.getContext()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity.name!)
        fetchRequest.returnsObjectsAsFaults = false
        
        do
        {
            let results = try managedContext.fetch(fetchRequest)
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }
            try managedContext.save()
        } catch let error as NSError {
            print("Detele all data in \(entity) error : \(error) \(error.userInfo)")
        }
        
    }
    static func executeThe(query: NSPredicate, forEntityName entity: String ) -> [NSManagedObject]{
        let context = self.getContext()
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        request.predicate = query
        //request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            return result as! [NSManagedObject]
            
        } catch {
            print("Failed query")
        }
        return []
        
    }
    
}
