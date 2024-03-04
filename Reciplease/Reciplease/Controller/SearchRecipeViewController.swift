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
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Functions
    // this button is pressed when the user have write all his ingredients and he wants the recipe
    @IBAction func searchForRecipeButton(_ sender: Any) {
        
        guard ingredientsListLabel.text != "" else {
            self.presentAlert(title: "OK", message: "Vous n'avez rien dans votre frigot ? Veuillez rentrer un ingredient")
            return
        }
        shared.fetchAPIData(ingredient: ingredientsListLabel.text!) { success, data in
            guard success == true else {
                print("Oups ! Il y a une erreur.")
                return
            }
            self.recipes = data!.hits
            self.ingredients = ""
            DispatchQueue.main.async {
                self.activityIndicator.isHidden = false
                self.ingredientsListLabel.text = ""
                self.performSegue(withIdentifier: "segueToList", sender: self)
            }
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
    
    /*
     // MARK: - Navigation
     DECLARATION :
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
             if segue.identifier == "nomDuSegue" {
                 let VC = segue.destination as! nomDuVC
                // action like pushing data to the VC
             }
         }

     APPEL :
     self.performSegue(withIdentifier: "nomDuSegue", sender: self)
     */
    
}
