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
    static var favoriteRecipeCell = "ReusableCell"
    
    
    var recipes: [FavoriteRecipe] = []
    let manager = CoreDataStack()
    
    // MARK: - Outlets
    @IBOutlet weak var favoriteTableView: UITableView!
    
    // Fetches the saved favorite recipes from CoreData when the view loads.
    override func viewDidLoad() {
        favoriteTableView.register(TableViewCell.nib(), forCellReuseIdentifier: TableViewCell.identifier)
        super.viewDidLoad()
    }
    
    // Reloads the table view data when the view appears to reflect any changes in the saved recipes.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        do {
            recipes = try manager.viewContext.fetch(request)
            DispatchQueue.main.async {
                self.favoriteTableView.reloadData()
            }
        } catch {
            print("error => \(error)")
        }
    }
    
    // Presents a privacy notice alert to inform users about data storage practices.
    @IBAction func didClickInformationButton(_ sender: Any) {
        Helper.presentAlert(from: self, title: "Privacy Notice", message: "We care about your privacy! Reciplease collects and stores data locally on your device to enhance your experience. This includes saving your favorite recipes for quick access. Rest assured, no data is shared externally. Your privacy is our priority!")
    }
    
    // Prepares data to be passed to the next view controller when a segue is triggered.
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let recipe = sender as? FavoriteRecipe,
           let destination = segue.destination as? FavoriteRecipeViewController,
           segue.identifier == "segueToFavoriteRecipeClicked" {
            destination.recipe = recipe
        }
    }
}


// UITableViewDataSource Extension
extension FavoriteTableViewRecipeSavedViewController: UITableViewDataSource {
    // Specifies the number of rows in the table view.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    // Specifies the number of sections in the table view.
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Specifies the height for each row in the table view.
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0; // Choose your custom row height
    }
    
    // Configures and returns a cell for the specified row.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as? TableViewCell
        let recipe = recipes[indexPath.row]
        if let recipeName = recipe.recipeName, let ingredients = recipe.ingredients {
            cell!.configure(recipeName: recipeName, recipeIngredients: ingredients, forXpeople: Int(recipe.forXpeople), recipeTime: Double(recipe.timeToPrepare), image: recipe.image!)
        }
        return cell!
    }
}

// UITableViewDelegate Extension
extension FavoriteTableViewRecipeSavedViewController: UITableViewDelegate {
    // Handles the selection of a row in the table view.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectRecipe = recipes[indexPath.row]
        self.performSegue(withIdentifier: "segueToFavoriteRecipeClicked", sender: selectRecipe)
    }
    
    // Presents an alert for failed operations or successful deletions
    
    // Handles the deletion of a row in the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let index = indexPath.row
            let selectFavoriteRecipe = recipes[indexPath.row]
            manager.viewContext.delete(selectFavoriteRecipe)
            do {
                try manager.viewContext.save()
            } catch {
                Helper.presentAlert(from: self, title: "Backup of the recipe failed", message: "Check your network connection.")
            }
            recipes.remove(at: index)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
}
