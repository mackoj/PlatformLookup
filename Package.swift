// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "PlatformLookup",
  platforms: [.macOS(.v10_14)],
  products: [
    .executable(name: "cli", targets: ["cli"]),
    .library(name: "CommandParser", targets: ["CommandParser"]),
    .library(name: "SimulatorControl", targets: ["SimulatorControl"]),
    .library(name: "Shell", targets: ["Shell"]),
    .library(name: "PlatformLookup", targets: ["PlatformLookup"]),
  ],
  dependencies: [
    .package(url: "https://github.com/mrackwitz/Version.git", from: "0.7.2"),
    .package(
      url: "https://github.com/pointfreeco/swift-snapshot-testing.git",
      from: "1.7.0"
    ),
  ],
  targets: [
    .target(name: "cli", dependencies: ["PlatformLookup", "CommandParser"]),
    .target(
      name: "PlatformLookup",
      dependencies: ["SimulatorControl", "Shell"]
    ), .target(name: "Shell"),
    .target(name: "SimulatorControl", dependencies: ["Version"]),
    .target(name: "CommandParser", dependencies: ["PlatformLookup"]),
    .testTarget(
      name: "PlatformLookupTests",
      dependencies: ["PlatformLookup", "SnapshotTesting"]
    ), .testTarget(name: "ShellTests", dependencies: ["Shell"]),
  ],
  swiftLanguageVersions: [.v5]
)
