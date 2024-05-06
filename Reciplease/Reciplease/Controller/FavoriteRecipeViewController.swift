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
        guard let imageUrlString = recipe.image, let _ = URL(string: imageUrlString) else {
            Helper.presentAlert(from: self, title: "ERROR", message: "We cannot access the URL, check your intenet connexion, or maybe the URL is not available.")
            return
        }
        Helper.getImage(from: imageUrlString) { image in
            if let image = image {
                DispatchQueue.main.async {
                    self.recipeImageView.image = image
                }
            } else {
                Helper.presentAlert(from: self, title: "Cannot retrieve Image", message: "We cannot retrieve the image, check your internet connection.")
            }
        }
        // Do any additional setup after loading the view.
    }
    // MARK: - Function
    
    // Handles the action of unfavorite button by deleting the recipe from CoreData.
    @IBAction func unfavoriteButton(_ sender: UIBarButtonItem) {
        manager.viewContext.delete(recipe)
        presentAlertAndAddAction(title: "Recipe deleted", message: "The recipe has been successfully deleted from the database")
    }
    @IBAction func getDirection(_ sender: Any) {
        // Check if the recipe URL is valid
        if let urlToOpen = URL(string: "\(String(describing: recipe.url))") {
            // Open the URL in Safari
            UIApplication.shared.open(urlToOpen)
        } else {
            // If URL is invalid, present an error alert
            Helper.presentAlert(from: self, title: "Error", message: "Sorry, we can't open this URL")
        }
    }
    
    // Presents a privacy notice alert.
    @IBAction func didClickInformationButton(_ sender: Any) {
        presentAlertAndAddAction(title: "Privacy Notice", message: "We care about your privacy! Reciplease collects and stores data locally on your device to enhance your experience. This includes saving your favorite recipes for quick access. Rest assured, no data is shared externally. Your privacy is our priority!")
    }
    
    // MARK: - Alert
    // Presents an alert with an OK button.
    func presentAlertAndAddAction(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        // Adds an OK action button to the alert.
        let okAction = UIAlertAction(title: "OK", style: .default) { action in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(okAction)
        // Shows the alert.
        self.present(alert, animated: true, completion: nil)
    }
}
