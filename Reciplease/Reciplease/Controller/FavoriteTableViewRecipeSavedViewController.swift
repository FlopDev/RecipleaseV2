//
//  FavoriteTableViewRecipeSavedViewController.swift
//  Reciplease
//
//  Created by Florian Peyrony on 12/02/2024.
//

import UIKit
import CoreData

class FavoriteTableViewRecipeSavedViewController: UIViewController {
    
    // MARK: - Properties
    static var favoriteRecipeCell = "favoriteRecipeCell"
    var recipes: [FavoriteRecipe] = []
    let manager = CoreDataStack()
    
    // MARK: - Outlets
    @IBOutlet weak var favoriteTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        guard (try? CoreDataStack.sharedInstance.viewContext.fetch(request)) != nil else {
            return
        }
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
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let recipe = sender as? FavoriteRecipe,
           let destination = segue.destination as? FavoriteRecipeViewController,
           segue.identifier == "segueToFavoriteRecipeClicked" {
            destination.recipe = recipe
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
        if let recipeName = recipe.recipeName, let ingredients = recipe.ingredients {
            cell!.configure(recipeName: recipeName, recipeIngredients: ingredients, forXpeople: Int(recipe.forXpeople), recipeTime: Double(recipe.timeToPrepare), image: recipe.image!)
        }
        return cell!
    }
}

extension FavoriteTableViewRecipeSavedViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectRecipe = recipes[indexPath.row]
        self.performSegue(withIdentifier: "segueToFavoriteRecipeClicked", sender: selectRecipe)
    }
    
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let index = indexPath.row
            let selectFavoriteRecipe = recipes[indexPath.row]
            manager.viewContext.delete(selectFavoriteRecipe)
            do {
                try manager.viewContext.save()
            } catch {
                presentAlert(title: "Backup of the recipe failed", message: "Check your network connection.")
            }
            recipes.remove(at: index)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
}
