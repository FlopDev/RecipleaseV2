//
//  SearchTableViewViewController.swift
//  Reciplease
//
//  Created by Florian Peyrony on 12/02/2024.

import UIKit

class SearchTableViewViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    static var recipeCell = "PresentRecipeCell"
    var recipes: [Hit] = []

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }


    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let recipe = sender as? Hit,
           let destination = segue.destination as? SoughtRecipeViewController,
           segue.identifier == "segueToRecipeClicked" {
            destination.recipe = recipe
            print("this is the recipe \(recipe)")
        }
    }

}
extension SearchTableViewViewController: UITableViewDataSource {
    
    // Méthode appelée pour configurer et retourner une cellule de tableau à afficher à l'index spécifié
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PresentRecipeCell", for: indexPath) as? PresentTableViewCell else {
            return UITableViewCell()
        }
        
        let recipe = recipes[indexPath.row].recipe
        let igredients = recipe.ingredients
            .map { $0.text }
            .joined(separator: ", ")
        cell.configure(recipeName: recipe.label,
                       recipeIngredients: "\(igredients)",
                       recipeTime: Double((recipe.totalTime)),
                       forXpeople: recipe.yield, image: recipe.image)
        return cell
    }
    
    // Méthode appelée pour retourner le nombre de sections dans le tableau
    func numberOfSections(in tableView: UITableView) -> Int {
        // Dans ce cas, nous avons une seule section
        return recipes.count
    }
    
    // Méthode appelée pour retourner le nombre de lignes dans la section spécifiée du tableau
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Dans ce cas, nous avons un seul élément dans la section
        return 1
    }
}

extension SearchTableViewViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("u tape on this cell")
        let selectRecipe = recipes[indexPath.row]
        self.performSegue(withIdentifier: "segueToRecipeClicked", sender: selectRecipe)
        
    }
}
