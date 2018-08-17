// Generated using Sourcery 0.11.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import XCTest

@testable import ValidatedTests;
extension ValidatedTests {
  static var allTests: [(String, (ValidatedTests) -> () throws -> Void)] = [
    ("testZipWith", testZipWith),
    ("testHigherOrderZips", testHigherOrderZips)
  ]
}

// swiftlint:disable trailing_comma
XCTMain([
  testCase(ValidatedTests.allTests),
])
// swiftlint:enable trailing_comma
