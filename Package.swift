// swift-tools-version:5.0
import PackageDescription

let package = Package(
  name: "Validated",
  products: [
    .library(
      name: "Validated",
      targets: ["Validated"]),
  ],
  dependencies: [
    .package(url: "https://github.com/pointfreeco/swift-nonempty.git", from: "0.1.2"),
  ],
  targets: [
    .target(
      name: "Validated",
      dependencies: ["NonEmpty"]),
    .testTarget(
      name: "ValidatedTests",
      dependencies: ["Validated"]),
  ]
)
