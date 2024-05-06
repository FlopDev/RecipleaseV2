//
//  PresentFavoriteTableViewCell.swift
//  Reciplease
//
//  Created by Florian Peyrony on 09/04/2024.
//

import Foundation
import UIKit
import Alamofire

class PresentFavoriteTableViewCell: UITableViewCell {
    
    // MARK: Properties
    let vc = FavoriteTableViewRecipeSavedViewController()
    
    // MARK: Outlets
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var favoriteRecipePicture: UIImageView!
    @IBOutlet weak var timeToPrepare: UILabel!
    @IBOutlet weak var recipeIngredients: UILabel!
    @IBOutlet weak var forXPeople: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // We fill the cells with the data we obtain
    func configure(recipeName: String, recipeIngredients: String, forXpeople: Int, recipeTime: Double, image: String) {
        self.layer.borderWidth = 2.5
        self.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.recipeName.text = recipeName
        self.forXPeople.text = "\(forXpeople) people(s)"
        self.recipeIngredients.text = recipeIngredients
        self.timeToPrepare.text = ("\(recipeTime) min")
        Helper.getImage(from: image) { image in
            guard let image = image else {
                print("error")
                Helper.presentAlert(from: self.vc, title: "ERROR", message: "We cannot retrieve the Image, check your internet connexion")
                return
            }
            DispatchQueue.main.async {
                self.favoriteRecipePicture.image = image
            }
        }
    }
}
