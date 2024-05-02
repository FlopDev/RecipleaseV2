//
//  CoreDataStack.swift
//  Reciplease
//
//  Created by Florian Peyrony on 07/03/2024.
//

import Foundation
import CoreData
import Alamofire


final class CoreDataStack {
    
    // MARK: - Singleton
    
    static let sharedInstance = CoreDataStack()
    
    // MARK: - Public
    
    var viewContext: NSManagedObjectContext {
        //On pourra utiliser notre contexte partout dans notre code en écrivant simplement  CoreDataStack.sharedInstance.viewContext
        return CoreDataStack.sharedInstance.persistentContainer.viewContext
    }
    
    func saveFavoriteRecipe(recipe: Hit) {
        // je peu utiliser viewContext directe au lieu du singleton ?
        let favoriteRecipe = FavoriteRecipe(context: CoreDataStack.sharedInstance.viewContext)
        favoriteRecipe.forXpeople = Int16(recipe.recipe.yield)
        favoriteRecipe.image = recipe.recipe.image
        let ingredients = recipe.recipe.ingredients
            .map { $0.text }
            .joined(separator: ", ")
        favoriteRecipe.ingredients = "\(ingredients)"
        favoriteRecipe.recipeName = recipe.recipe.label
        favoriteRecipe.timeToPrepare = Int16(recipe.recipe.totalTime)
        favoriteRecipe.url = recipe.recipe.url
        do {
            try CoreDataStack.sharedInstance.viewContext.save()
        } catch {
            print("error saving \(String(describing: favoriteRecipe.recipeName))")
        }
    }
    
    func deleteRecipe(recipe: FavoriteRecipe) {
        viewContext.delete(recipe)
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
