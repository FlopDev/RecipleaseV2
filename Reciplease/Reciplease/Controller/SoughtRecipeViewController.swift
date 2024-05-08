//
//  SoughtRecipeViewController.swift
//  Reciplease
//
//  Created by Florian Peyrony on 12/02/2024.
//

import UIKit
import Alamofire

class SoughtRecipeViewController: UIViewController {
    
    // MARK: - Properties
    var recipe: Hit!
    @IBOutlet weak var informationButton: UIBarButtonItem!
    
    // MARK: - Outlets
    @IBOutlet weak var makeFavoriteButton: UIBarButtonItem!
    @IBOutlet weak var timeToPrepareLabel: UILabel!
    @IBOutlet weak var forXPeople: UILabel!
    @IBOutlet weak var getDirectionButton: UIButton!
    @IBOutlet weak var ingredientsListLabel: UILabel!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet var cguButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeFavoriteButton.isAccessibilityElement = true
        makeFavoriteButton.accessibilityHint = "Ce bouton permet d'enregistrer une recette en favoris, vous pourrez retrouver la recette en appuyant sur le bouton Favorite avec la Loupe en image en bas de la vue"
        timeToPrepareLabel.isAccessibilityElement = true
        timeToPrepareLabel.accessibilityHint = "est le temps en minute qu'il faut pour la recette"
        forXPeople.isAccessibilityElement = true
        forXPeople.accessibilityHint = "Cela explique pour combien de personne est fait la recette"
        getDirectionButton.isAccessibilityElement = true
        getDirectionButton.accessibilityHint = "Ce bouton ouvrira la recette détaillée sur une page Safari"
        ingredientsListLabel.isAccessibilityElement = true
        ingredientsListLabel.accessibilityHint = "est la liste des ingrédients qu'il faut pour cette recette"
        recipeNameLabel.isAccessibilityElement = true
        recipeNameLabel.accessibilityHint = "est le nom de la recette"
        cguButton.isAccessibilityElement = true
        cguButton.accessibilityHint = "est le bouton qui vous permet de savoir ce que Reciplease fait de vos données"
        // Do any additional setup after loading the view.
        let ingredients = "\(recipe.recipe.ingredientLines)"
        let ingredientsList = ingredients
            .replacingOccurrences(of: "[", with: "-")
            .replacingOccurrences(of: ",", with: "\n-")
        
        ingredientsListLabel.text = ingredientsList
        recipeNameLabel.text = "\(recipe.recipe.label)"
        timeToPrepareLabel.text = "\(recipe.recipe.totalTime) min ⏲️"
        forXPeople.text = "for \(recipe.recipe.yield) 👨"
        Helper.getImage(from: recipe.recipe.image) { image in
            if let image = image {
                DispatchQueue.main.async {
                    self.recipeImageView.image = image
                }
            } else {
                Helper.presentAlert(from: self, title: "Cannot retrieve Image", message: "We cannot retrieve the image, check your internet connection.")
            }
        }

    }
    // MARK: - Functions
    
    // Function to open the recipe URL in Safari
    @IBAction func getDirection(_ sender: Any) {
        // Check if the recipe URL is valid
        if let urlToOpen = URL(string: "\(recipe.recipe.url)") {
            // Open the URL in Safari
            UIApplication.shared.open(urlToOpen)
        } else {
            // If URL is invalid, present an error alert
            Helper.presentAlert(from: self, title: "Error", message: "Sorry, we can't open this URL")
        }
    }

    // Function to show privacy notice
    @IBAction func didClickInformationButton(_ sender: Any) {
        // Present a privacy notice alert to the user
        Helper.presentAlert(from: self, title: "Privacy Notice", message: "We care about your privacy! Reciplease collects and stores data locally on your device to enhance your experience. This includes saving your favorite recipes for quick access. Rest assured, no data is shared externally. Your privacy is our priority!")
    }

    // Function to save recipe as favorite
    @IBAction func makeFavorite(_ sender: Any) {
        // Save the recipe as favorite using CoreData
        CoreDataStack.sharedInstance.saveFavoriteRecipe(recipe: recipe)
        // Present a confirmation alert to the user
        Helper.presentAlert(from: self, title: "Recipe Saved", message: "You can find the recipe by clicking on Favorite Button")
    }

    // MARK: - Navigation
}
