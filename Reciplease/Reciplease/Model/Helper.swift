//
//  Helper.swift
//  Reciplease
//
//  Created by Florian Peyrony on 06/05/2024.
//

import Foundation
import UIKit
import Alamofire

class Helper {
    
    var recipe: FavoriteRecipe!
    // Function to show an alert to  a specific controller
    static func presentAlert(from viewController: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        // Add a "OK" button to the alert
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        // Present the alert to the specific controller
        viewController.present(alert, animated: true, completion: nil)
    }
    
    static func getImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        AF.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                let image = UIImage(data: data)
                completion(image)
            case .failure(let error):
                print("Request error: \(error)")
                completion(nil)
            }
        }
    }
}

