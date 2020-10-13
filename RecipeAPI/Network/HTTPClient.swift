//
//  HTTPClient.swift
//  RecipeAPI
//
//  Created by Firoz Ansari on 13/10/2020.
//

import Foundation

public protocol HTTPClient {
    typealias Result = Swift.Result<RecipeList, Error>

    func get(from url: URL, completion: @escaping (Result) -> Void)
}
