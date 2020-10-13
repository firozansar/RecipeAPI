//
//  RemoteRecipeLoaderTests.swift
//  RecipeAPITests
//
//  Created by Firoz Ansari on 13/10/2020.
//

import RecipeAPI
import XCTest


class RemoteRecipeLoaderTests : XCTestCase {
    func test_init_doesNotRequestDataFromURL() {
        let url = URL(string: "https://a-url.com")!
        let (_, client) = makeSUT(url: url)

        XCTAssertTrue(client.requestedURLs.isEmpty)
    }

    func test_load_requestsDataFromURL() {
        let url = URL(string: "https://a-url.com")!
        let (sut, client) = makeSUT(url: url)

        sut.load { _ in }

        XCTAssertEqual(client.requestedURLs, [url])
    }

    func test_loadTwice_requestsDataFromURLTwice() {
        let url = URL(string: "https://a-url.com")!
        let (sut, client) = makeSUT(url: url)

        sut.load { _ in }
        sut.load { _ in }

        XCTAssertEqual(client.requestedURLs, [url, url])
    }

    func test_load_deliversErrorOnClientError() {
        let (sut, client) = makeSUT()

        expect(sut, toCompleteWith: .failure(.HTTPClientError), when: {
            let clientError = NSError(domain: "Test", code: 0)
            client.complete(with: clientError)
        })
    }

    func test_load_deliversNoItemsOnSuccessfulResponseWithEmptyList() {
        let (sut, client) = makeSUT()

        expect(sut, toCompleteWith: .success([]), when: {
            client.complete(with: [])
        })
    }

    func test_load_deliversItemsOnSuccessfulResponseWithItems() {
        let cakeList = [generateRecipe("pasta")]

        let (sut, client) = makeSUT()

        expect(sut, toCompleteWith: .success(cakeList), when: {
            client.complete(with: cakeList)
        })
    }

    func test_load_doesNotDeliverResultAfterSUTInstanceHasBeenDeallocated() {
        let client = HTTPClientSpy()
        let url = URL(string: "https://a-url.com")!
        var sut: RemoteRecipeLoader? = RemoteRecipeLoader(url: url, client: client)

        var capturedResults = [RemoteRecipeLoader.Result]()
        sut?.load { capturedResults.append($0) }

        sut = nil
        client.complete(with: [])

        XCTAssertTrue(capturedResults.isEmpty)
    }

    // MARK: Helpers

    private func makeSUT(url: URL = URL(string: "https://a-url.com")!) -> (sut: RemoteRecipeLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteRecipeLoader(url: url, client: client)
        trackForMemoryLeaks(client)
        trackForMemoryLeaks(sut)
        return (sut, client)
    }

    private func expect(_ sut: RemoteRecipeLoader, toCompleteWith result: RecipeLoader.Result, when action: () -> Void, file: StaticString = #file, line: UInt = #line) {

        var capturedResults = [RecipeLoader.Result]()
        sut.load { capturedResults.append($0) }

        action()

        XCTAssertEqual(capturedResults, [result], file: file, line: line)
    }

    class HTTPClientSpy: HTTPClient {
        private var messages = [(url: URL, completion: (HTTPClient.Result) -> Void)]()
        var requestedURLs: [URL] {
            messages.map { $0.url }
        }

        func get(from url: URL, completion: @escaping (HTTPClient.Result) -> Void) {
            messages.append((url, completion))
        }

        func complete(with error: Error) {
            messages[0].completion(.failure(error))
        }

        func complete(with items: RecipeList) {
            messages[0].completion(.success(items))
        }
    }
}
