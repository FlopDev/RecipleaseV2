//
//  TestCoreData.swift
//  RecipleaseServiceTestsCase
//
//  Created by Florian Peyrony on 04/01/2022.
//

import XCTest

import XCTest
@testable import Reciplease
import CoreData


extension Hit {
    static func with(name: String, url: String) -> Hit {
        return Hit(recipe: Recipe(name: name, url: url))
    }
}


class TestCoreData: XCTestCase {
    
    var saveFavoriteRecipe: API!
    var recipeSaved: FavoriteRecipe?
    var alamofireService: API?
    var expectation: XCTestExpectation!
    var saveRecipe: CoreDataStack?
    let coreDataService = CoreDataStack()
    let manager = CoreDataStack()

    
    
    
    
    func testSavingRecipe() {
        
        // Given
        let hit = Hit.with(name: "Totot", url: "http://google.com")
        let hit2 = Hit.with(name: "Totot", url: "http://google.com")
       
    
        // When
        print(" HOW MANY ELEMENT IN DATABASE\(manager.viewContext.accessibilityElementCount())")
        self.coreDataService.saveFavoriteRecipe(recipe: hit)
        
        // then
        XCTAssertNotNil(coreDataService.viewContext)
        XCTAssertEqual(hit.recipe.image, hit2.recipe.image)
        // verifier que la recipe est bien la bonne
    }
    
    func testDeleatingRecipe() {
        // given
        var numberOfFavoritesRecipes = 0
        var numberOfRecipesAfterDeleating = 0
        var recipes: [FavoriteRecipe] = []
        let hit = Hit.with(name: "Toto", url: "http://google.com")
        self.coreDataService.saveFavoriteRecipe(recipe: hit)
        
        
        let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        do {
            recipes = try manager.viewContext.fetch(request)
            numberOfFavoritesRecipes = recipes.count
            numberOfRecipesAfterDeleating = numberOfFavoritesRecipes
        } catch {
            print("error => \(error)")
        }
        print(" HOW MANY ELEMENT IN DATABASE\(manager.viewContext.accessibilityElementCount())")
        print(" HOW MANY ELEMENT IN DATABASE\(numberOfFavoritesRecipes)")

        // when
        coreDataService.deleteRecipe(recipe: recipes[0])
        
        do {
            recipes = try manager.viewContext.fetch(request)
            numberOfRecipesAfterDeleating = recipes.count
            print(" HOW MANY ELEMENT IN DATABASE AFTER DELEATING\(numberOfRecipesAfterDeleating)")
        } catch {
            print("error => \(error)")
        }
        
        // then
        XCTAssertNotEqual(numberOfFavoritesRecipes, numberOfRecipesAfterDeleating)
    }
}
