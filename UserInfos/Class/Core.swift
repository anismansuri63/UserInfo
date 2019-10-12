//
//  Core.swift
//  Core Data
//
//  Created by    on 25/03/18.
//  Copyright © 2018   . All rights reserved.
//

import UIKit
import CoreData

extension NSManagedObject {
    @discardableResult
    func save() -> Bool {
        return Core.shared.saveContext()
    }
    static func fetchRecords<T: NSManagedObject>(predicate: NSPredicate? = nil) -> [T] {
        let fetchR = NSFetchRequest<T>(entityName: T.className)
        //let fetchR: NSFetchRequest<Users> = Users.fetchRequest()

        fetchR.predicate = predicate
        
        let viewContext = Core.shared.persistentContainer.viewContext
        do {
            //records = try viewContext.fetch(T.fetchRequest()) as! [T]
            return try viewContext.fetch(fetchR)
            //return records
            
        } catch {
            print(error.localizedDescription)
            UIAlertController.showAlert(message: error.localizedDescription)
            return []
        }
    }
}
class Core: NSObject {
    static let shared = Core()

    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "UserInfos")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    @discardableResult
    func saveContext () -> Bool {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                let nserror = error as NSError
                switch nserror.code {
                case 1600:
                    UIAlertController.showAlert(message:"You must delete tied up entity first.")
                default:
                    UIAlertController.showAlert(message: nserror.localizedDescription)
                }
                //fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                return false
            }
        }
        return true
    }
    @discardableResult
    func delete<T: NSManagedObject>(_ array: [T]) -> Bool {
        let viewContext = Core.shared.persistentContainer.viewContext
        _ = array.map{
            
            viewContext.delete($0)
        }
         return self.saveContext()
    }
}
