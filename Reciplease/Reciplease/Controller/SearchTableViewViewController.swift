//
//  SearchTableViewViewController.swift
//  Reciplease
//
//  Created by Florian Peyrony on 12/02/2024.

import UIKit

class SearchTableViewViewController: UIViewController {
    
    // MARK: - Properties
    static var recipeCell = "ReusableCell"
    var recipes: [Hit] = []
    
    // MARK: - Outlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var informationButton: UIBarButtonItem!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        tableView.register(TableViewCell.nib(), forCellReuseIdentifier: TableViewCell.identifier)
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    // Tell the user how we use his data
    @IBAction func didClickInformationButton(_ sender: Any) {
        Helper.presentAlert(from: self, title: "Privacy Notice", message: "We care about your privacy! Reciplease collects and stores data locally on your device to enhance your experience. This includes saving your favorite recipes for quick access. Rest assured, no data is shared externally. Your privacy is our priority!")
    }
    
    // MARK: - Navigation
    // segue to send data to nexr Controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let recipe = sender as? Hit,
           let destination = segue.destination as? SoughtRecipeViewController,
           segue.identifier == "segueToRecipeClicked" {
            destination.recipe = recipe
        }
    }
}

extension SearchTableViewViewController: UITableViewDataSource {
    
    // Show the cell to the user at the good index
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewViewController.recipeCell, for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        let recipe = recipes[indexPath.row].recipe
        let ingredients = recipe.ingredients
            .map { $0.text }
            .joined(separator: ", ")
        cell.configure(recipeName: recipe.label,
                       recipeIngredients: "\(ingredients)",
                       forXpeople: recipe.yield, recipeTime: Double((recipe.totalTime)), image: recipe.image)
        return cell
    }
    
    // Méthode appelée pour retourner le nombre de sections dans le tableau
    func numberOfSections(in tableView: UITableView) -> Int {
        // Dans ce cas, nous avons une seule section
        return 1
    }
    
    // Méthode appelée pour retourner le nombre de lignes dans la section spécifiée du tableau
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Dans ce cas, nous avons un seul élément dans la section
        return recipes.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0;//Choose your custom row height
    }
}

extension SearchTableViewViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectRecipe = recipes[indexPath.row]
        self.performSegue(withIdentifier: "segueToRecipeClicked", sender: selectRecipe)
    }
}
