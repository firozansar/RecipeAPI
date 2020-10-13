//
//  XCTest+Helpers.swift
//  RecipeAPITests
//
//  Created by Firoz Ansari on 13/10/2020.
//
import RecipeAPI
import XCTest

extension XCTestCase {
    
    func generateRecipe(_ name: String) -> Recipe {
        Recipe(name: name, ingredients: [generateIngredient()], steps: ["String"], timers: [0], imageURL: "https://fake-url.com", originalURL: "https://fake-url.com")

    }
    
    func generateIngredient() -> Ingredient {
        Ingredient(quantity: "1", name: "beef", type: "meat")
    }
        
}
