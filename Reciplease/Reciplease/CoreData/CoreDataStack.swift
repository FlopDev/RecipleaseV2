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
    
    var viewContext: NSManagedObjectContext {
        //On pourra utiliser notre contexte partout dans notre code en écrivant simplement  CoreDataStack.sharedInstance.viewContext
        return CoreDataStack.sharedInstance.persistentContainer.viewContext
    }
    
    func saveFavoriteRecipe(forXpeople: Int, image: String, ingredients: String, recipeName: String, timeToPrepare: Int, url: String) {
        // je peu utiliser viewContext directe au lieu du singleton ?
        let favoriteRecipe = FavoriteRecipe(context: CoreDataStack.sharedInstance.viewContext)
        favoriteRecipe.forXpeople = Int16(forXpeople)
        favoriteRecipe.image = image
        favoriteRecipe.ingredients = ingredients
        favoriteRecipe.recipeName = recipeName
        favoriteRecipe.timeToPrepare = Int16(timeToPrepare)
        favoriteRecipe.url = url
        do {
            try CoreDataStack.sharedInstance.viewContext.save()
        } catch {
            print("error saving \(String(describing: favoriteRecipe.recipeName))")
        }
    }
    
    func fetchData() {
        let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
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
