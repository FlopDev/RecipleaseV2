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
    }
    
    // MARK: - Functions
    
    
    @IBAction func addIngredient(_ sender: Any) {
        
        if searchIngredientTextField.text!.isEmpty == true {
            self.presentAlert(title: "Erreur", message: "Veuillez rentrer un ingredient à rechercher")
        } else {
            ingredientsListLabel.text! += "- \(searchIngredientTextField.text!)\n"
            ingredients += " \(searchIngredientTextField.text!)"
        }
        searchIngredientTextField.text = ""
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        searchIngredientTextField.resignFirstResponder()
    }
    
    // this button is pressed when the user have write all his ingredients and he wants the recipe
    @IBAction func searchForRecipeButton(_ sender: Any) {
        
        guard ingredients != "" else {
            self.presentAlert(title: "OK", message: "Vous n'avez rien dans votre frigot ? Veuillez rentrer un ingredient")
            return
        }
        shared.fetchAPIData(ingredient: ingredients) {  success, data in
            guard success == true else {
                print("Oups ! Il y a une erreur.")
                return
            }
            
            DispatchQueue.main.async {
                self.recipes = data!.hits
                self.ingredients = ""
                self.activityIndicator.isHidden = false
                self.ingredientsListLabel.text = ""
                self.performSegue(withIdentifier: "segueToTableViewVC", sender: self.recipes)
            }
        }
    }
    
    @IBAction func clearIngredients(_ sender: UIButton) {
        DispatchQueue.main.async {
            self.ingredientsListLabel.text = ""
            self.ingredients = ""
        }
    }
    
    // MARK: - Alert
    func presentAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        // show the alert
        self.present(alert, animated: true, completion: nil)
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
