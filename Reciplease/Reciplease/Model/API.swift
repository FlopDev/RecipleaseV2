//
//  API.swift
//  Reciplease
//
//  Created by Florian Peyrony on 22/02/2024.
//

import Foundation
import Alamofire


// Classe API responsable de la gestion des requêtes réseau et du stockage des recettes
class API {
    // Instance partagée unique de la classe API
    static let shared = API()
    
    // Tableau des recettes
    var recipes: [Hit] = []
    
    // Session de gestion des requêtes réseau
    private let manager: Session
    
    // Initialisateur de la classe API
    init(manager: Session = AF) {
        // Initialisation de la session réseau
        self.manager = manager
    }
    
    // Méthode pour récupérer les données de l'API
    func fetchAPIData(ingredient: String, callback: @escaping(Bool, RecipeFound?) -> Void) {
        // Construction de l'URL avec l'ingrédient fourni
        let url = URL(string: "https://api.edamam.com/search?q=\(ingredient.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&app_id=19dbb1a1&app_key=f606398872ec03bd2037562d3b5d898e")!
        
        // Envoi de la requête à l'URL spécifiée
        _ = manager.request(url).responseData { data in
            // Traitement des données reçues
            switch data.result {
            case .success(let data):
                do {
                    let responseJSON = try JSONDecoder().decode(RecipeFound.self, from: data)
                    let objectRecipe = RecipeFound(q: responseJSON.q, from: responseJSON.from, to: responseJSON.to, more: responseJSON.more, count: responseJSON.count, hits: responseJSON.hits)
                    callback(true, objectRecipe)
                } catch let error {
                    print("Error decoding JSON: \(error)")
                    callback(false, nil)
                }

                
            case .failure(let error):
                // Gestion des erreurs de requête
                print("Something went wrong: \(error)")
                // Appel du callback avec un indicateur d'échec
                callback(false, nil)
            }
        }
    }
}
