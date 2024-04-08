//
//  FavoriteRecipeViewController.swift
//  Reciplease
//
//  Created by Florian Peyrony on 08/02/2024.
//

import UIKit

class FavoriteRecipeViewController: UIViewController {
    
    var recipe: FavoriteRecipe!
    
    

    // MARK: - Outlets
    @IBOutlet weak var returnButton: UINavigationItem!
    
    @IBOutlet weak var getDirectionButton: UIButton!
    @IBOutlet weak var ingredientsListLabel: UILabel!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var timeToPrepareLabel: UILabel!
    
    @IBOutlet weak var forXPeopleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        returnButton.titleView?.tintColor = #colorLiteral(red: 0.2, green: 0.8, blue: 0.5, alpha: 1.0)
        ingredientsListLabel.text = recipe.ingredients
        recipeNameLabel.text = recipe.recipeName
        timeToPrepareLabel.text = "\(recipe.timeToPrepare) min"
        forXPeopleLabel.text = "for \(recipe.forXpeople)p"
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
