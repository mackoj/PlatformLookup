// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

//let package = Package(
//  name: "Version",
//  targets: [
//    Target.target(
//      name: <#T##String#>,
//                  dependencies: <#T##[Target.Dependency]#>,
//                  path: "Version",
//                  exclude: <#T##[String]#>, sources: <#T##[String]?#>, publicHeadersPath: <#T##String?#>, cSettings: <#T##[CSetting]?#>, cxxSettings: <#T##[CXXSetting]?#>, swiftSettings: <#T##[SwiftSetting]?#>, linkerSettings: <#T##[LinkerSetting]?#>)
//  ],
//  swiftLanguageVersions: <#T##[SwiftVersion]?#>,
//  cLanguageStandard: <#T##CLanguageStandard?#>,
//  cxxLanguageStandard: <#T##CXXLanguageStandard?#>
//)

let package = Package(
    name: "SimulatorControl",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "SimulatorControl",
            targets: ["SimulatorControl"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
      .package(url: "https://github.com/mackoj/Version.git", .branch( "master")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "SimulatorControl",
            dependencies: ["Version"]),
        .testTarget(
            name: "SimulatorControlTests",
            dependencies: ["SimulatorControl"]),
    ]
)
