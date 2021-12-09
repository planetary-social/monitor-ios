// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Monitor",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Monitor",
            targets: ["Monitor"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(name: "Logger",
                 path: "../logger-ios"),
        .package(name: "Secrets",
                 path: "../secrets-ios"),
        .package(name: "Bugsnag",
                 url: "https://github.com/bugsnag/bugsnag-cocoa",
                 from: "6.9.5"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Monitor",
            dependencies: ["Logger", "Secrets", "Bugsnag"]),
        .testTarget(
            name: "MonitorTests",
            dependencies: ["Monitor"]),
    ]
)
