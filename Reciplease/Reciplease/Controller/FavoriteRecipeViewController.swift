//
//  FavoriteRecipeViewController.swift
//  Reciplease
//
//  Created by Florian Peyrony on 08/02/2024.
//

import UIKit

class FavoriteRecipeViewController: UIViewController {

    @IBOutlet weak var returnButton: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        returnButton.titleView?.tintColor = #colorLiteral(red: 0.2, green: 0.8, blue: 0.5, alpha: 1.0)
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
