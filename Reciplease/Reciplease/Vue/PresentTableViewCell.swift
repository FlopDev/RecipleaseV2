//
//  PresentTableViewCell.swift
//  Reciplease
//
//  Created by Florian Peyrony on 26/05/2021.
//

import UIKit

class PresentTableViewCell: UITableViewCell {
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeIngredients: UILabel!
    @IBOutlet weak var forXpeople: UILabel!
    @IBOutlet weak var recipeTime: UILabel!
    @IBOutlet weak var greyView: UIView!
    @IBOutlet weak var encartView: UIView!
    @IBOutlet weak var recipeImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addShadow()
        // Initialization code
        
    }
    
    func configure(recipeName: String, recipeIngredients: String, recipeTime: Double, forXpeople: Int, image: String) {
        self.layer.borderWidth = 2.5
        self.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        encartView.layer.borderColor = UIColor.gray.cgColor
        encartView.layer.borderWidth = 1.0
        self.recipeName.text = recipeName
        self.recipeIngredients.text = recipeIngredients
        self.forXpeople.text = "\(forXpeople) people(s)"
        self.recipeTime.text = String("\(recipeTime) min")
        getImage(image: image)
    }
    
    func getImage(image: String) {
       let url = URL(string: image)!
    if let data = try? Data(contentsOf: url) {
               // Create Image and Update Image View
        recipeImage.image = UIImage(data: data)
      }
    }
    
    private func addShadow() {
        greyView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7).cgColor
        greyView.layer.shadowRadius = 2.0
        greyView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        greyView.layer.shadowOpacity = 2.0
    }
}
