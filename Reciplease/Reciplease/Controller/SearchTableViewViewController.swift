//
//  SearchTableViewViewController.swift
//  Reciplease
//
//  Created by Florian Peyrony on 12/02/2024.
//

import UIKit

class SearchTableViewViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    static var recipeCell = "recipeCell"

    override func viewDidLoad() {
        super.viewDidLoad()

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
extension SearchTableViewViewController: UITableViewDataSource {
    
    // Méthode appelée pour configurer et retourner une cellule de tableau à afficher à l'index spécifié
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Récupère une cellule réutilisable avec l'identifiant spécifié
        let recipeCell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewViewController.recipeCell, for: indexPath)
        // Retourne la cellule configurée
        return recipeCell
    }
    
    // Méthode appelée pour retourner le nombre de sections dans le tableau
    func numberOfSections(in tableView: UITableView) -> Int {
        // Dans ce cas, nous avons une seule section
        return 1
    }
    
    // Méthode appelée pour retourner le nombre de lignes dans la section spécifiée du tableau
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Dans ce cas, nous avons un seul élément dans la section
        return 1
    }
}
