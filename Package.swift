// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "PlatformLookup",
  platforms: [.macOS(.v10_15)],
  products: [
    .executable(name: "cli", targets: ["cli"]),
    .library(name: "AutomaticDescription", targets: ["AutomaticDescription"]),
    .library(name: "CommandParser", targets: ["CommandParser"]),
    .library(name: "SimulatorControl", targets: ["SimulatorControl"]),
    .library(name: "Shell", targets: ["Shell"]),
    .library(name: "PlatformLookup", targets: ["PlatformLookup"]),
  ],
  dependencies: [
    .package(url: "https://github.com/mrackwitz/Version.git", from: "0.7.2"),
    .package(url: "https://github.com/pointfreeco/swift-nonempty.git", from: "0.2.0")
  ],
  targets: [
    .target(name: "cli", dependencies: ["PlatformLookup", "CommandParser", "AutomaticDescription"]),
    .target(
      name: "PlatformLookup",
      dependencies: ["SimulatorControl", "Shell", "NonEmpty"]
    ), .target(name: "Shell"),
    .target(name: "SimulatorControl", dependencies: ["Version"]),
    .target(name: "AutomaticDescription"),
    .target(name: "CommandParser", dependencies: ["PlatformLookup"]),
    .testTarget(
      name: "PlatformLookupTests",
      dependencies: ["PlatformLookup"]
    ), .testTarget(name: "ShellTests", dependencies: ["Shell"]),
  ],
  swiftLanguageVersions: [.v5]
)
