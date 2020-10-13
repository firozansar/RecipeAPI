//
//  XCTest+MemoryLeakTracking.swift
//  RecipeAPITests
//
//  Created by Firoz Ansari on 13/10/2020.
//

import XCTest

extension XCTestCase {
    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated. Potencial memory leak", file: file, line: line)
        }
    }
}
