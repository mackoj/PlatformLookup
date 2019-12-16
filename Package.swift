// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "PlatformLookup",
  platforms: [.macOS(.v10_14)],
  products: [
    .executable(name: "plCLI", targets: ["cli"]),
    .library(name: "SimulatorControl", targets: ["SimulatorControl"]),
    .library(name: "Shell", targets: ["Shell"]),
    .library(name: "PlatformLookup", targets: ["PlatformLookup"]),
  ],
  dependencies: [
    .package(
      url: "https://github.com/apple/swift-tools-support-core.git",
      .branch("master")
    ),  // en attendant une release stable
    .package(url: "https://github.com/mrackwitz/Version.git", from: "0.7.2"),
    .package(
      url: "https://github.com/pointfreeco/swift-snapshot-testing.git",
      from: "1.7.0"
    ),
  ],
  targets: [
    .target(name: "cli", dependencies: ["PlatformLookup", "SwiftToolsSupport"]),
    .target(
      name: "PlatformLookup",
      dependencies: ["SimulatorControl", "Shell"]
    ), .target(name: "Shell"),
    .target(name: "SimulatorControl", dependencies: ["Version"]),
    .testTarget(
      name: "PlatformLookupTests",
      dependencies: ["PlatformLookup", "SnapshotTesting"]
    ), .testTarget(name: "ShellTests", dependencies: ["Shell"]),
  ],
  swiftLanguageVersions: [.v5]
)
