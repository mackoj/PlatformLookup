// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "PlatformLookup",
  platforms: [.macOS(.v10_15)],
  products: [
    .executable(name: "cli", targets: ["cli"]),
    .library(name: "PlatformLookup", targets: ["PlatformLookup"]),
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-argument-parser.git", from: "0.0.4"),
    .package(url: "https://github.com/mackoj/AutomaticDescription.git", from: "1.0.0"),
    .package(url: "https://github.com/mackoj/Shell.git", from: "1.0.0"),
    .package(url: "https://github.com/mackoj/SimulatorControl.git", from: "1.0.0"),
    .package(url: "https://github.com/pointfreeco/swift-nonempty.git", from: "0.2.0"),
  ],
  targets: [
    .target(name: "cli", dependencies: ["PlatformLookup", "AutomaticDescription", .product(name: "ArgumentParser", package: "swift-argument-parser")]),
    .target(
      name: "PlatformLookup",
      dependencies: ["SimulatorControl", "Shell", "NonEmpty"]
    ),
    .testTarget(
      name: "PlatformLookupTests",
      dependencies: ["PlatformLookup"]
    ), .testTarget(name: "ShellTests", dependencies: ["Shell"]),
  ],
  swiftLanguageVersions: [.v5]
)
