//
//  API.swift
//  Reciplease
//
//  Created by Florian Peyrony on 22/02/2024.
//

import Foundation
import Alamofire


class API {
    static let shared = API()
    var recipes: [Hit] = []
    
    private let manager: Session
   init(manager: Session = AF) {
       self.manager = manager
   }
    
    func fetchAPIData(ingredient: String, callback: @escaping(Bool, RecipeFound?) -> Void) {
        let url = URL(string: "https://api.edamam.com/search?q=\(ingredient.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&app_id=19dbb1a1&app_key=f606398872ec03bd2037562d3b5d898e")!
        
        _ = manager.request(url).responseData { data in
            
                 switch data.result {
                   case .success(let data):
                    do { let responseJSON = try JSONDecoder().decode(RecipeFound.self,from: data)
                        self.recipes = responseJSON.hits
                        let objectWelcome = RecipeFound(q: responseJSON.q, from: responseJSON.from, to: responseJSON.to, more: responseJSON.more, count: responseJSON.count, hits: responseJSON.hits)
                        callback(true, objectWelcome)
                    } catch {
                        print("error")
                    }
                    
                   case .failure(let error):
                       print("Something went wrong: \(error)")
                     callback(false, nil)
                   }
            }
        }
    func apiCall(ingredient: String) {
        print("getInFunction")
        AF.request("https://api.edamam.com/search?q=\(ingredient)&app_id=19dbb1a1&app_key=f606398872ec03bd2037562d3b5d898e").response {  data in

            switch data.result {
              case .success(let data):
                do { let responseJSON = try JSONDecoder().decode(RecipeFound.self,from: data!)
                   self.recipes = responseJSON.hits
                   let objectWelcome = RecipeFound(q: responseJSON.q, from: responseJSON.from, to: responseJSON.to, more: responseJSON.more, count: responseJSON.count, hits: responseJSON.hits)
                   print(objectWelcome.hits)
               } catch {
                   print("error")
               }
               
              case .failure(let error):
                  print("Something went wrong: \(error)")
                //callback(false, nil)
              }
       }
        }
    }
