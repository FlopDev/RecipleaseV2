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

    // ne marche pas, je récupere pas la cellule coorrectement
    
    @IBOutlet weak var recipeName: UILabel!
    
    
    @IBOutlet weak var favoriteRecipePicture: UIImageView!
    @IBOutlet weak var timeToPrepare: UILabel!
    @IBOutlet weak var recipeIngredients: UILabel!
    @IBOutlet weak var forXPeople: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        //addShadow()
        // Initialization code
    }
    
    func configure(recipeName: String, recipeIngredients: String, forXpeople: Int, recipeTime: Double, image: String) {
        //encartView.layer.borderColor = UIColor.gray.cgColor
        //encartView.layer.borderWidth = 1.0
        self.layer.borderWidth = 2.5
        self.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.recipeName.text = recipeName
        self.forXPeople.text = "\(forXpeople) people(s)"
        self.recipeIngredients.text = recipeIngredients
        self.timeToPrepare.text = ("\(recipeTime) min")
        getImage(image: image)
    }
    func getImage(image: String) {
       let url = URL(string: image)!
        DispatchQueue.main.async {
            
            AF.request(url).responseData { response in
                switch response.result {
                case .success(let data):
                    // Traitement des données reçues ici
                    self.favoriteRecipePicture.image = UIImage(data: data)
                case .failure(let error):
                    print("Erreur de requête : \(error)")
                }
            }

            
            //if let data = try? Data(contentsOf: url) {
            //    // Create Image and Update Image View
            //
            //}
        }
    }
    
   //private func addShadow() {
   //    greyView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7).cgColor
   //    greyView.layer.shadowRadius = 2.0
   //    greyView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
   //    greyView.layer.shadowOpacity = 2.0
   //}
}
