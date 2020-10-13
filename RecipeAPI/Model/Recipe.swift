//
//  Recipe.swift
//  RecipeAPI
//
//  Created by Firoz Ansari on 13/10/2020.
//

import Foundation

public typealias RecipeList = [Recipe]

public struct Recipe: Codable, Equatable {
    
    public let name: String
    public let ingredients: [Ingredient]
    public let steps: [String]
    public let timers: [Int]
    public let imageURL: String
    public let originalURL: String
    
    public init(name: String, ingredients: [Ingredient], steps: [String], timers: [Int], imageURL: String, originalURL: String){
        self.name = name
        self.ingredients = ingredients
        self.steps = steps
        self.timers = timers
        self.imageURL = imageURL
        self.originalURL = originalURL        
    }
    
    public static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        return lhs.name == rhs.name
    }
        
}
