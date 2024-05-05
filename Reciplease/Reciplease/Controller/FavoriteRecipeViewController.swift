//
//  FavoriteRecipeViewController.swift
//  Reciplease
//
//  Created by Florian Peyrony on 08/02/2024.
//

import UIKit
import Alamofire

class FavoriteRecipeViewController: UIViewController {
    
    // MARK: - Properties
    var recipe: FavoriteRecipe!
    let manager = CoreDataStack()
    let tableViewController = FavoriteTableViewRecipeSavedViewController()
    
    // MARK: - Outlets
    @IBOutlet weak var returnButton: UINavigationItem!
    @IBOutlet weak var getDirectionButton: UIButton!
    @IBOutlet weak var ingredientsListLabel: UILabel!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var timeToPrepareLabel: UILabel!
    @IBOutlet weak var informationButton: UIBarButtonItem!
    @IBOutlet weak var forXPeopleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        returnButton.titleView?.tintColor = #colorLiteral(red: 0.2, green: 0.8, blue: 0.5, alpha: 1.0)
        ingredientsListLabel.text = recipe.ingredients
        recipeNameLabel.text = recipe.recipeName
        timeToPrepareLabel.text = "\(recipe.timeToPrepare) min ⏲️"
        forXPeopleLabel.text = "for \(recipe.forXpeople) 👨"
        
        getImage()
        // Do any additional setup after loading the view.
    }
    // MARK: - Function
    
    // Handles the action of unfavorite button by deleting the recipe from CoreData.
    @IBAction func unfavoriteButton(_ sender: UIBarButtonItem) {
        manager.viewContext.delete(recipe)
        presentAlert(title: "Recipe deleted", message: "The recipe has been successfully deleted from the database")
    }
    
    // Retrieves and sets the image for the recipe.
    func getImage() {
        let url = URL(string: recipe.image!)!
        AF.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                self.recipeImageView.image = UIImage(data: data)
                // Data processing here
            case .failure(let error):
                print("Request error: \(error)")
            }
        }
    }
    
    // Presents a privacy notice alert.
    @IBAction func didClickInformationButton(_ sender: Any) {
        presentAlert(title: "Privacy Notice", message: "We care about your privacy! Reciplease collects and stores data locally on your device to enhance your experience. This includes saving your favorite recipes for quick access. Rest assured, no data is shared externally. Your privacy is our priority!")
    }
    
    // Presents an alert with an OK button.
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        // Adds an OK action button to the alert.
        let okAction = UIAlertAction(title: "OK", style: .default) { action in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(okAction)
        
        // Shows the alert.
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Navigation
    // Prepares for segue to the FavoriteTableViewRecipeSavedViewController.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToFavoriteTableView" {
            _ = segue.destination as! FavoriteTableViewRecipeSavedViewController
        }
    }
}
