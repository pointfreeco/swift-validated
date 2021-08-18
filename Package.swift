// swift-tools-version:5.0

import PackageDescription

let package = Package(
  name: "swift-validated",
  products: [
    .library(
      name: "Validated",
      targets: ["Validated"]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/pointfreeco/swift-nonempty.git", from: "0.2.1"),
  ],
  targets: [
    .target(
      name: "Validated",
      dependencies: ["NonEmpty"]
    ),
    .testTarget(
      name: "ValidatedTests",
      dependencies: ["Validated"]
    ),
  ]
)
