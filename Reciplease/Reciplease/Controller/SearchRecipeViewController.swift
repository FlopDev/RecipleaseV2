//
//  SearchRecipeViewController.swift
//  Reciplease
//
//  Created by Florian Peyrony on 08/02/2024.
//

import UIKit

class SearchRecipeViewController: UIViewController {
    
    // MARK: - Properties
    let shared = API()
    var ingredients = ""
    var recipes: [Hit] = []
    
    // MARK: - Outlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchRecipeButton: UIButton!
    @IBOutlet weak var ingredientsListLabel: UILabel!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var searchIngredientTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator.isHidden = true
        clearButton.isAccessibilityElement = true
        clearButton.accessibilityHint = "Ce bouton permet de nettoyer les éléments de la liste des ingrédients"
        searchRecipeButton.isAccessibilityElement = true
        searchRecipeButton.accessibilityHint = "Appuyer sur ce bouton quand vous avez renseignez des ingrédients"
        searchIngredientTextField.isAccessibilityElement = true
        searchIngredientTextField.accessibilityHint = "Veuillez renseignez des ingrédients, puis appuyer sur le bouton add"
        addButton.isAccessibilityElement = true
        addButton.accessibilityHint = "Veuillez appuyer sur le bouton Add quand vous avez renseignez un ingrédient dans le champs de texte à gauche de ce bouton"
        ingredientsListLabel.isAccessibilityElement = true
        ingredientsListLabel.accessibilityHint = "Cette liste contient les ingrédients que vous avez renseigné, si vous souhaiter supprimer un ou plusieurs éléments, appuyez sur le bouton Clear"
    }
    
    // MARK: - Functions
    // Function to handle adding ingredients
    @IBAction func addIngredient(_ sender: Any) {
        // Check if the search ingredient text field is empty
        if searchIngredientTextField.text!.isEmpty == true {
            // If empty, present an alert to inform the user
            Helper.presentAlert(from: self, title: "Error", message: "Please enter an ingredient to search for")
        } else {
            // If not empty, add the ingredient to the ingredients list label
            ingredientsListLabel.text! += "- \(searchIngredientTextField.text!)\n"
            // Also add the ingredient to the ingredients string
            ingredients += " \(searchIngredientTextField.text!)"
        }
        // Clear the search ingredient text field
        searchIngredientTextField.text = ""
    }

    // Function to dismiss the keyboard when tapped outside the text field
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        // Resign the first responder status of the search ingredient text field
        searchIngredientTextField.resignFirstResponder()
    }

    
    // this button is pressed when the user have write all his ingredients and he wants the recipes
    @IBAction func searchForRecipeButton(_ sender: Any) {
        // Check if there are ingredients entered
        guard ingredients != "" else {
            // If no ingredients, present an alert to inform the user
            Helper.presentAlert(from: self, title: "OK", message: "You don't have anything in your fridge? Please enter an ingredient")
            return
        }
        // Call the API to fetch recipe data using the entered ingredients
        shared.fetchAPIData(ingredient: ingredients) { success, data in
            // Check if API call was successful
            guard success == true else {
                // If not successful, print an error pop up to the user
                Helper.presentAlert(from: self, title: "ERROR", message: "Oops! There's an error, check your internet connexion")
                return
            }
            // Update UI on the main thread
            DispatchQueue.main.async {
                // Store the fetched recipes
                self.recipes = data!.hits
                // Clear the ingredients for the next search
                self.ingredients = ""
                // Show the activity indicator
                self.activityIndicator.isHidden = false
                // Clear the ingredients list label
                self.ingredientsListLabel.text = ""
                // Perform segue to the table view controller to display the recipes
                self.performSegue(withIdentifier: "segueToTableViewVC", sender: self.recipes)
            }
        }
    }

    // Function to clear entered ingredients
    @IBAction func clearIngredients(_ sender: UIButton) {
        // Update UI on the main thread
        DispatchQueue.main.async {
            // Clear the ingredients list label
            self.ingredientsListLabel.text = ""
            // Clear the ingredients
            self.ingredients = ""
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToTableViewVC" {
            let VC = segue.destination as! SearchTableViewViewController
            VC.recipes = recipes
        }
    }
}

extension SearchRecipeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
