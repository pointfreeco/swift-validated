import XCTest
import Validated

func validate(id: Int) -> Validated<Int, String> {
  return id > 0
    ? .valid(id)
    : .error("id must be greater than zero")
}

func validate(name: String) -> Validated<String, String> {
  return !name.isEmpty
    ? .valid(name)
    : .error("name can't be blank")
}

struct User: Equatable {
  let id: Int
  let name: String
}

final class ValidatedTests: XCTestCase {
  func testZipWith() {
    let validUser = zip(with: User.init)(
      validate(id: 1),
      validate(name: "Blob")
    )
    XCTAssertTrue(validUser.isValid)
    XCTAssertEqual(User(id: 1, name: "Blob"), validUser.value)
    XCTAssertNil(validUser.errors)
    let validMessage = validUser.validate(
      ifValid: { "\($0.name) is valid!" },
      ifInvalid: { $0.joined(separator: ", ") }
    )
    XCTAssertEqual("Blob is valid!", validMessage)

    let invalidUser = zip(with: User.init)(
      validate(id: -1),
      validate(name: "")
    )
    XCTAssertFalse(invalidUser.isValid)
    XCTAssertNil(invalidUser.value)
    XCTAssertEqual(
      NonEmptyArray(
        "id must be greater than zero",
        "name can't be blank"
      ),
      invalidUser.errors
    )
    let invalidMessage = invalidUser.validate(
      ifValid: { "\($0.name) is valid!" },
      ifInvalid: { $0.joined(separator: ", ") }
    )
    XCTAssertEqual("id must be greater than zero, name can't be blank", invalidMessage)

    let partiallyInvalidUser1 = zip(with: User.init)(
      validate(id: 1),
      validate(name: "")
    )
    XCTAssertEqual(
      NonEmptyArray(
        "name can't be blank"
      ),
      partiallyInvalidUser1.errors
    )
    let partiallyInvalidUser2 = zip(with: User.init)(
      validate(id: -1),
      validate(name: "Blob")
    )
    XCTAssertEqual(
      NonEmptyArray(
        "id must be greater than zero"
      ),
      partiallyInvalidUser2.errors
    )

    XCTAssertNotEqual(validUser, invalidUser)
    XCTAssertNotEqual(invalidUser, validUser)
    XCTAssertNotEqual(partiallyInvalidUser1, partiallyInvalidUser2)
  }

  func testHigherOrderZips() {
    struct A: Equatable {
      let a1: Int
      let a2: Int
      let a3: Int
      let a4: Int
      let a5: Int
      let a6: Int
      let a7: Int
      let a8: Int
      let a9: Int
      let a10: Int
    }

    let validA = zip(with: A.init)(
      validate(id: 1),
      validate(id: 2),
      validate(id: 3),
      validate(id: 4),
      validate(id: 5),
      validate(id: 6),
      validate(id: 7),
      validate(id: 8),
      validate(id: 9),
      validate(id: 10)
    )

    XCTAssertEqual(
      .valid(A(a1: 1, a2: 2, a3: 3, a4: 4, a5: 5, a6: 6, a7: 7, a8: 8, a9: 9, a10: 10)),
      validA
    )
  }
}
