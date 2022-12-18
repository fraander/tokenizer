//
//  TokenizeTests.swift
//  TokenizeTests
//
//  Created by Frank Anderson on 12/18/22.
//

import XCTest

final class TokenizeTests: XCTestCase {
    /// Test tokenize handles trailing tokens properly
    func testTrailing() {
        let input = "Peanut Butter #trader-joes"
        let output: (String, Set<String>) = ("Peanut Butter", ["trader-joes"])
        let result = input.tokenize(with: "#")
        XCTAssert(output.0 == result.0, "Incorrect content")
        XCTAssert(output.1 == result.1, "Incorrect tokens")
    }
    
    /// Test tokenize handles leading tokens properly
    func testLeading() {
        let input = "#whole-foods Fresh Tilapia"
        let output: (String, Set<String>) = ("Fresh Tilapia", ["whole-foods"])
        let result = input.tokenize(with: "#")
        XCTAssert(output.0 == result.0, "Incorrect content")
        XCTAssert(output.1 == result.1, "Incorrect tokens")
    }
    
    /// Test tokenize handles duplicated and middle tokens properly
    func testMiddleDuplicated() {
        let input = "Eggs #target #trader-joes (18 size)"
        let output: (String, Set<String>) = ("Eggs (18 size)", ["target", "trader-joes"])
        let result = input.tokenize(with: "#")
        XCTAssert(output.0 == result.0, "Incorrect content")
        XCTAssert(output.1 == result.1, "Incorrect tokens")
    }
    
    /// Test tokenizing using a different token
    func testAtToken() {
        let input = "@today do thing from @colleague for @meeting"
        let output: (String, Set<String>) = ("do thing from for", ["today", "colleague", "meeting"])
        let result = input.tokenize(with: "@")
        XCTAssert(output.0 == result.0, "Incorrect content")
        XCTAssert(output.1 == result.1, "Incorrect tokens")
    }
    
    /// Test ignore with "\" works as intended using a different token
    func testIgnore() {
        let input = "@today do thing from \\@colleague for \\@meeting"
        let output: (String, Set<String>) = ("do thing from @colleague for @meeting", ["today"])
        let result = input.tokenize(with: "@")
        XCTAssert(output.0 == result.0, "Incorrect content; \(output.0); \(result.0)")
        XCTAssert(output.1 == result.1, "Incorrect tokens")
    }
    
    /// Test ignore character only removed when preceding the token that should be removed
    func testIgnoreWithoutToken() {
        let input = "@today do thing from \\@colleague for \\%meeting"
        let output: (String, Set<String>) = ("do thing from @colleague for \\%meeting", ["today"])
        let result = input.tokenize(with: "@")
        XCTAssert(output.0 == result.0, "Incorrect content; \(output.0); \(result.0)")
        XCTAssert(output.1 == result.1, "Incorrect tokens")
    }
}
