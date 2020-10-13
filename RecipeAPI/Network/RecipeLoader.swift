//
//  RecipeLoader.swift
//  RecipeAPI
//
//  Created by Firoz Ansari on 13/10/2020.
//

import Foundation

public protocol RecipeLoader {
    typealias Result = Swift.Result<RecipeList, LoadingError>

    func load(completion: @escaping (Result) -> Void)
}

public enum LoadingError: Error {
    case HTTPClientError
}

