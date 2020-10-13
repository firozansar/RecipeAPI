//
//  Ingredient.swift
//  RecipeAPI
//
//  Created by Firoz Ansari on 13/10/2020.
//

import Foundation

public struct Ingredient: Codable {
    let quantity, name, type: String
    
    public init(quantity: String, name: String, type: String){
        self.quantity = quantity
        self.name = name
        self.type = type
    }
}

