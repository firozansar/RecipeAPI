//
//  RemoteRecipeLoader.swift
//  RecipeAPI
//
//  Created by Firoz Ansari on 13/10/2020.
//

import Foundation

public class RemoteRecipeLoader : RecipeLoader {
    let url: URL
    let client: HTTPClient

    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }

    public func load(completion: @escaping (RecipeLoader.Result) -> Void) {
        client.get(from: url, completion: strongify(weak: self, closure: { _, result in
            switch result {
            case let .success(items):
                completion(.success(items))
            case .failure:
                completion(.failure(.HTTPClientError))
            }
        }))
    }
}
