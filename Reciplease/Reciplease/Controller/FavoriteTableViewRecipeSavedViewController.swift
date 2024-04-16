//
//  FavoriteTableViewRecipeSavedViewController.swift
//  Reciplease
//
//  Created by Florian Peyrony on 12/02/2024.
//

import UIKit
import CoreData

class FavoriteTableViewRecipeSavedViewController: UIViewController {

    @IBOutlet weak var favoriteTableView: UITableView!
    static var favoriteRecipeCell = "favoriteRecipeCell"
    var recipes: [FavoriteRecipe] = []
    let manager = CoreDataStack()
    override func viewDidLoad() {
        super.viewDidLoad()
        let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        guard let favoritesRecipes = try? CoreDataStack.sharedInstance.viewContext.fetch(request) else {
            return
        }
        print(favoritesRecipes.count)
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        do {
            recipes = try manager.viewContext.fetch(request)
            favoriteTableView.reloadData()
        } catch {
            print("error => \(error)")
        }
        favoriteTableView.reloadData()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let recipe = sender as? FavoriteRecipe,
           let destination = segue.destination as? FavoriteRecipeViewController,
           segue.identifier == "segueToFavoriteRecipeClicked" {
            destination.recipe = recipe
            print("\(destination.recipe)")

        }
    }

}

extension FavoriteTableViewRecipeSavedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0;//Choose your custom row height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PresentFavoriteRecipeCell", for: indexPath) as? PresentFavoriteTableViewCell
        
        
        let recipe = recipes[indexPath.row]
        print(recipe.recipeName)
        if let recipeName = recipe.recipeName, let ingredients = recipe.ingredients {
            cell!.configure(recipeName: recipeName, recipeIngredients: ingredients, forXpeople: Int(recipe.forXpeople), recipeTime: Double(recipe.timeToPrepare), image: recipe.image!)
        }
        return cell!
    }
}

extension FavoriteTableViewRecipeSavedViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("u tape on this cell")
        let selectRecipe = recipes[indexPath.row]
        self.performSegue(withIdentifier: "segueToFavoriteRecipeClicked", sender: selectRecipe)
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let index = indexPath.row
            let selectFavoriteRecipe = recipes[indexPath.row]
            print(manager.viewContext)
            manager.viewContext.delete(selectFavoriteRecipe)
            do {
                // Enregistrez les modifications apportées au contexte pour finaliser la suppression
                try manager.viewContext.save()
                // La suppression a réussi
            } catch {
                // Une erreur s'est produite lors de la suppression
                print("Erreur lors de la suppression de l'objet : \(error)")
            }
            print(manager.viewContext)
            recipes.remove(at: index)
            tableView.deleteRows(at: [indexPath], with: .left)
            
        }
    }
}
