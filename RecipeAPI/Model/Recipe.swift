//
//  Recipe.swift
//  RecipeAPI
//
//  Created by Firoz Ansari on 13/10/2020.
//

import Foundation

public struct Recipe: Codable {
    let name: String
    let ingredients: [Ingredient]
    let steps: [String]
    let timers: [Int]
    let imageURL: String
    let originalURL: String
}
