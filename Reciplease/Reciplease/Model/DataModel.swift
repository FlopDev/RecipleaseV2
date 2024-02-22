//
//  DataModel.swift
//  Reciplease
//
//  Created by Florian Peyrony on 22/02/2024.
//

import Foundation

// MARK: - RecipeFound
struct RecipeFound: Codable {
    let q: String
    let from, to: Int
    let more: Bool
    let count: Int
    let hits: [Hit]
}

// MARK: - Hit
struct Hit: Codable {
    let recipe: Recipe
}

// MARK: - Recipe
struct Recipe: Codable {
    let uri: String
    let label: String
    let image: String
    let source: String
    let url: String
    let shareAs: String
    let yield: Int
    let dietLabels, healthLabels, cautions, ingredientLines: [String]
    let ingredients: [Ingredient]
    let calories, totalWeight: Double
    let totalTime: Double
    let totalNutrients, totalDaily: [String: Total]
    let digest: [Digest]
    let cuisineType, mealType, dishType: [String]?
    
    init(name: String, url: String) {
        self.label = name
        self.url = url
        image = ""
        uri = ""
        source = ""
        shareAs = ""
        yield = 0
        dietLabels = []
        healthLabels = []
        cautions = []
        ingredientLines = []
        ingredients = []
        calories = 0.0
        totalWeight = 0.0
        totalTime = 0.0
        totalNutrients = [:]
        totalDaily = [:]
        digest = []
        cuisineType = nil
        mealType = nil
        dishType = nil
        
    }
}

// MARK: - Digest
struct Digest: Codable {
    let label, tag: String
    let schemaOrgTag: SchemaOrgTag?
    let total: Double
    let hasRDI: Bool
    let daily: Double
    let unit: Unit
    let sub: [Digest]?
}

enum SchemaOrgTag: String, Codable {
    case carbohydrateContent = "carbohydrateContent"
    case cholesterolContent = "cholesterolContent"
    case fatContent = "fatContent"
    case fiberContent = "fiberContent"
    case proteinContent = "proteinContent"
    case saturatedFatContent = "saturatedFatContent"
    case sodiumContent = "sodiumContent"
    case sugarContent = "sugarContent"
    case transFatContent = "transFatContent"
}

enum Unit: String, Codable {
    case empty = "%"
    case g = "g"
    case kcal = "kcal"
    case mg = "mg"
    case µg = "µg"
}

// MARK: - Ingredient
struct Ingredient: Codable {
    let text: String
    let weight: Double
    let foodCategory: String?
    let foodID: String
    let image: String?

    enum CodingKeys: String, CodingKey {
        case text, weight, foodCategory
        case foodID = "foodId"
        case image
    }
}

// MARK: - Total
struct Total: Codable {
    let label: String
    let quantity: Double
    let unit: Unit
}
