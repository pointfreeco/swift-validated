// swift-tools-version:5.0
import Foundation
import PackageDescription

let package = Package(
  name: "Validated",
  products: [
    .library(
      name: "Validated",
      targets: ["Validated"]),
  ],
  dependencies: [
    .package(url: "https://github.com/pointfreeco/swift-nonempty.git", from: "0.2.0"),
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

if ProcessInfo.processInfo.environment.keys.contains("PF_DEVELOP") {
  package.dependencies.append(
    contentsOf: [
      .package(url: "https://github.com/yonaskolb/XcodeGen.git", from: "2.3.0"),
    ]
  )
}
