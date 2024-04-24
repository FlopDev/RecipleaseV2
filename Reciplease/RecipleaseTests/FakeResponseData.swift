//
//  FakeResponseData.swift
//  RecipleaseServiceTestsCase
//
//  Created by Florian Peyrony on 10/10/2021.
//

import Foundation

class FakeResponseData {
    
    // I create one good response with good statusCode and one bad with 500 statutsCode
    static let responseOK = HTTPURLResponse(url: URL(string: "www.google.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
    static let responseKO = HTTPURLResponse(url: URL(string: "www.google.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)
    
    // I create the error
    class RecipeError: Error {}
    
    static let error = RecipeError()
    
    
    // Get the bundle to get Recipe.json
    static var recipeCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Recipe", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    // create the incorrectData
    static let recipeIncorrectData = "error".data(using: .utf8)!
  
    
    // we create a fake Image
    static let imageData = "image".data(using: .utf8)!
    
}
