// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "SimulatorControl",
  platforms: [.macOS(.v10_14)],
  products: [
    .library(
      name: "SimulatorControl",
      targets: ["SimulatorControl"]),
    .library(
      name: "Shell",
      targets: ["Shell"]),
    .library(
      name: "PlatformLookup",
      targets: ["PlatformLookup"]),
  ],
  dependencies: [
    .package(url: "https://github.com/mrackwitz/Version.git", from: "0.7.2"),
  ],
  targets: [
    .target(name: "PlatformLookup", dependencies: ["SimulatorControl", "Shell"]),
    .target(name: "Shell"),
    .target(name: "SimulatorControl", dependencies: ["Version"]),
    .testTarget(name: "PlatformLookupTests", dependencies: ["PlatformLookup"]),
    .testTarget(name: "SimulatorControlTests", dependencies: ["SimulatorControl"]),
    .testTarget(name: "ShellTests", dependencies: ["Shell"]),
  ],
  swiftLanguageVersions: [.v5]
)
