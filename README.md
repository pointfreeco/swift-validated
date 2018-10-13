# 🛂 Validated

[![Swift 4.1](https://img.shields.io/badge/swift-4.1-ED523F.svg?style=flat)](https://swift.org/download/)
[![iOS/macOS CI](https://img.shields.io/circleci/project/github/pointfreeco/swift-validated/master.svg?label=ios/macos)](https://circleci.com/gh/pointfreeco/swift-validated)
[![Linux CI](https://img.shields.io/travis/pointfreeco/swift-validated/master.svg?label=linux)](https://travis-ci.org/pointfreeco/swift-validated)
[![@pointfreeco](https://img.shields.io/badge/contact-@pointfreeco-5AA9E7.svg?style=flat)](https://twitter.com/pointfreeco)

A result type that accumulates multiple errors.

## Table of Contents

  - [Motivation](#motivation)
      - [The problem](#the-problem)
      - [Handling multiple errors with Validated](#handling-multiple-errors-with-validated)
  - [Installation](#installation)
  - [Interested in learning more?](#interested-in-learning-more)
  - [License](#license)

## Motivation

### The problem

Swift error handling short-circuits on the first failure. Because of this, it's not the greatest option for handling things like form data, where multiple inputs may result in multiple errors.

``` swift
struct User {
  let id: Int
  let email: String
  let name: String
}

func validate(id: Int) throws -> Int {
  guard id > 0 else {
    throw Invalid.error("id must be greater than zero")
  }
  return id
}

func validate(email: String) throws -> String {
  guard email.contains("@") else {
    throw Invalid.error("email must be valid")
  }
  return email
}

func validate(name: String) throws -> String {
  guard !name.isEmpty else {
    throw Invalid.error("name can't be blank")
  }
  return name
}

func validateUser(id: Int, email: String, name: String) throws -> User {
  return User(
    id: try validate(id: id),
    email: try validate(id: email),
    name: try validate(id: name)
  )
}
```

Here we've combined a few throwing functions into a single throwing function that may return a `User`.

``` swift
let user = try validateUser(id: 1, email: "blob@pointfree.co", name: "Blob")
// User(id: 1, email: "blob@pointfree.co", name: "Blob")
```

If the `id`, `email`, or `name` are invalid, an error is thrown.

``` swift
let user = try validateUser(id: 1, email: "blob@pointfree.co", name: "")
// throws Invalid.error("name can't be blank")
```

Unfortunately, if several or all of these inputs are invalid, the first error wins.

``` swift
let user = try validateUser(id: -1, email: "blobpointfree.co", name: "")
// throws Invalid.error("id must be greater than zero")
```

### Handling multiple errors with Validated

`Validated` is a [`Result`](https://github.com/antitypical/Result)-like type that can accumulate multiple errors. Instead of using `throw`ing functions, we can define functions that work with `Validated`.

``` swift
func validate(id: Int) -> Validated<Int, String> {
  return id > 0
    ? .valid(id)
    : .error("id must be greater than zero")
}

func validate(email: String) -> Validated<String, String> {
  return email.contains("@")
    ? .valid(email)
    : .error("email must be valid")
}

func validate(name: String) -> Validated<String, String> {
  return !name.isEmpty
    ? .valid(name)
    : .error("name can't be blank")
}
```

To accumulate errors, we use a function that we may already be familiar with: `zip`. 

``` swift
let validInputs = zip(
  validate(id: 1),
  validate(email: "blob@pointfree.co"),
  validate(name: "Blob")
)
// Validated<(Int, String, String), String>
```

The `zip` function on `Validated` works much the same way it works on sequences, but rather than zipping a pair of sequences into a sequence of pairs, it zips up a group of single `Validated` values into single `Validated` value of a group.

From here, we can use another function that we may already be familiar with, `map`, which takes a transform function and produces a new `Validated` value with its valid case transformed.

``` swift
let validUser = validInputs.map(User.init)
// valid(User(id: 1, email: "blob@pointfree.co", name: "Blob"))
```

Out group of valid inputs has transformed into a valid user.

For ergonomics and composition, a curried `zip(with:)` function is provided that takes both a transform function and `Validated` inputs.

``` swift
zip(with: User.init)(
  validate(id: 1),
  validate(email: "blob@pointfree.co"),
  validate(name: "Blob")
)
// valid(User(id: 1, email: "blob@pointfree.co", name: "Blob"))
```

An invalid input yields an error in the `invalid` case.

``` swift
zip(with: User.init)(
  validate(id: 1),
  validate(email: "blob@pointfree.co"),
  validate(name: "")
)
// invalid(["name can't be blank"])
```

More importantly, multiple invalid inputs yield an `invalid` case with multiple errors.

``` swift
zip(with: User.init)(
  validate(id: -1),
  validate(email: "blobpointfree.co"),
  validate(name: "")
)
// invalid([
//   "id must be greater than zero",
//   "email must be valid",
//   "name can't be blank"
// ])
```

Invalid errors are held in a [non-empty array](https://github.com/pointfreeco/swift-nonempty.git) to provide a compile-time guarantee that you will never encounter an empty `invalid` case.

## Installation

### Carthage

If you use [Carthage](https://github.com/Carthage/Carthage), you can add the following dependency to your `Cartfile`:

``` ruby
github "pointfreeco/swift-validated" ~> 0.1
```

### CocoaPods

If your project uses [CocoaPods](https://cocoapods.org), just add the following to your `Podfile`:

``` ruby
pod 'PointFree-Validated', '~> 0.1'
```

### SwiftPM

If you want to use Validated in a project that uses [SwiftPM](https://swift.org/package-manager/), it's as simple as adding a `dependencies` clause to your `Package.swift`:

``` swift
dependencies: [
  .package(url: "https://github.com/pointfreeco/swift-validated.git", from: "0.1.1")
]
```

### Xcode Sub-project

Submodule, clone, or download Validated, and drag `Validated.xcodeproj` into your project.

## Interested in learning more?

These concepts (and more) are explored thoroughly in [Point-Free](https://www.pointfree.co), a video series exploring functional programming and Swift hosted by [Brandon Williams](https://github.com/mbrandonw) and [Stephen Celis](https://github.com/stephencelis).

Validated was explored in [The Many Faces of Zip: Part 2](https://www.pointfree.co/episodes/ep24-the-many-faces-of-zip-part-2):

<a href="https://www.pointfree.co/episodes/ep24-the-many-faces-of-zip-part-2">
  <img alt="video poster image" src="https://d1hf1soyumxcgv.cloudfront.net/0024-zip-pt2/poster.jpg" width="480">
</a>

## License

All modules are released under the MIT license. See [LICENSE](LICENSE) for details.
