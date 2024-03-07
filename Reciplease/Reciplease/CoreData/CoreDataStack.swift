//
//  CoreDataStack.swift
//  Reciplease
//
//  Created by Florian Peyrony on 07/03/2024.
//

import Foundation
import CoreData
final class CoreDataStack {
    
    // MARK: - Singleton
    
    static let sharedInstance = CoreDataStack()
    
    // MARK: - Public
    
    var myProperty: AnyObject? // <--- Propriété exemple  CoreDataStack.sharedInstance.myProperty
    
    var viewContext: NSManagedObjectContext {
        //On pourra utiliser notre contexte partout dans notre code en écrivant simplement  CoreDataStack.sharedInstance.viewContext
        return CoreDataStack.sharedInstance.persistentContainer.viewContext
    }
    
    // MARK: - Private
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Reciplease")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
}
