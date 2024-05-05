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
    
    @IBAction func didClickInformationButton(_ sender: Any) {
        presentAlert(title: "Privacy Notice", message: "We care about your privacy! Reciplease collects and stores data locally on your device to enhance your experience. This includes saving your favorite recipes for quick access. Rest assured, no data is shared externally. Your privacy is our priority!")
    }
    
    func getImage() {
        let url = URL(string: recipe.recipe.image)!
        
        AF.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                self.recipeImageView.image = UIImage(data: data)
                // Traitement des données reçues ici
            case .failure(let error):
                print("Erreur de requête : \(error)")
            }
        }
    }
    
    @IBAction func makeFavorite(_ sender: Any) {
        CoreDataStack.sharedInstance.saveFavoriteRecipe(recipe: recipe)
        // makeFavoriteButton.image = UIImage(named: "star.fill")
        presentAlert(title: "Recipe Saved", message: "You can find the recipe by clicking on Favorite Button")
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
