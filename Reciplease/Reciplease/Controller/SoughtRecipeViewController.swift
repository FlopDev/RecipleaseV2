//
//  SoughtRecipeViewController.swift
//  Reciplease
//
//  Created by Florian Peyrony on 12/02/2024.
//

import UIKit

class SoughtRecipeViewController: UIViewController {
    
    var recipe: Hit!
    
    @IBOutlet weak var makeFavoriteButton: UIBarButtonItem!
    @IBOutlet weak var timeToPrepareLabel: UILabel!
    
    @IBOutlet weak var forXPeople: UILabel!
    @IBOutlet weak var getDirectionButton: UIButton!
    @IBOutlet weak var ingredientsListLabel: UILabel!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let ingredients = "\(recipe.recipe.ingredientLines)"
        let ingredientsList = ingredients
            .replacingOccurrences(of: "[", with: "-")
            .replacingOccurrences(of: ",", with: "\n-")
        
        ingredientsListLabel.text = ingredientsList
        
        recipeNameLabel.text = "\(recipe.recipe.label)"
        timeToPrepareLabel.text = "\(recipe.recipe.totalTime) min ⏲️"
        forXPeople.text = "for \(recipe.recipe.yield) 👨"
        getImage()
    }
    // MARK: - Function
    @IBAction func getDirection(_ sender: Any) {
        if let urlToOpen = URL(string: "\(recipe.recipe.url)") {
            UIApplication.shared.open(urlToOpen)
        } else {
            presentAlert(title: "Error", message: "Sorry, we can't open this URL")
        }
    }
    
    func getImage() {
        let url = URL(string: recipe.recipe.image)!
        if let data = try? Data(contentsOf: url) {
               // Create Image and Update Image View
            recipeImageView.image = UIImage(data: data)
           }
    }

    @IBAction func makeFavorite(_ sender: Any) {
        CoreDataStack.sharedInstance.saveFavoriteRecipe(recipe: recipe)
        // makeFavoriteButton.image = UIImage(named: "star.fill")
        // TODO: - Rajouter pop up pour avertir que c'est bien save ?
    }
    
    func presentAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    // MARK: - Navigation
}
