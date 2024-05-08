//
//  TableViewCell.swift
//  Reciplease
//
//  Created by Florian Peyrony on 06/05/2024.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var cell: UIView!
    
    @IBOutlet var customImageView: UIImageView!
    @IBOutlet weak var ingredients: UILabel!
    @IBOutlet weak var nameOfRecipe: UILabel!
    @IBOutlet weak var forXPeople: UILabel!
    @IBOutlet weak var timeToPrepare: UILabel!
    static let identifier = "ReusableCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "TableViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        nameOfRecipe.isAccessibilityElement = true
        nameOfRecipe.accessibilityHint = "est le nom de la recette"
        ingredients.isAccessibilityElement = true
        ingredients.accessibilityHint = "Sont les ingrédients présents dans la recette"
        forXPeople.isAccessibilityElement = true
        forXPeople.accessibilityHint = "Cela explique pour combien de personne est fait la recette"
        timeToPrepare.isAccessibilityElement = true
        timeToPrepare.accessibilityHint = "est le temps en minute qu'il faut pour la recette"
    }
    
    func configure(recipeName: String, recipeIngredients: String, forXpeople: Int, recipeTime: Double, image: String) {
        self.layer.borderWidth = 2.5
        self.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.nameOfRecipe.text = recipeName
        self.forXPeople.text = "for \(forXpeople) 👨"
        self.ingredients.text = recipeIngredients
        self.timeToPrepare.text = ("\(recipeTime) ⏲️")
        Helper.getImage(from: image) { image in
            guard let image = image else {
                print("error")
                return
            }
            DispatchQueue.main.async {
                self.customImageView.image = image
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
