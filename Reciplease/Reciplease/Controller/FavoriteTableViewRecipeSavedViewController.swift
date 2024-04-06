//
//  FavoriteTableViewRecipeSavedViewController.swift
//  Reciplease
//
//  Created by Florian Peyrony on 12/02/2024.
//

import UIKit
import CoreData

class FavoriteTableViewRecipeSavedViewController: UIViewController {

    @IBOutlet weak var favoriteTableView: UITableView!
    static var favoriteRecipeCell = "favoriteRecipeCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        guard let favoritesRecipes = try? CoreDataStack.sharedInstance.viewContext.fetch(request) else {
            return
        }
        print(favoritesRecipes.count)
        
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let recipe = sender as? Hit,
           let destination = segue.destination as? FavoriteRecipeViewController,
           segue.identifier == "nameOfTheSegue" {
            destination.recipe = recipe
            print("\(destination.recipe)")
            // appel : self.performSegue(withIdentifier: "nameOfTheSegue", sender: recipe)
        }
    }

}

extension FavoriteTableViewRecipeSavedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0;//Choose your custom row height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let favoriteRecipeCell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewRecipeSavedViewController.favoriteRecipeCell, for: indexPath)
        return favoriteRecipeCell
    }
    
}
