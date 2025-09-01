// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Rebrickable.package",
    platforms: [
        .macOS(.v15), .iOS(.v18), .tvOS(.v18), .watchOS(.v11)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Rebrickable.package",
            targets: ["Rebrickable.package"]
        ),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Rebrickable.package"
        ),
        .testTarget(
            name: "Rebrickable.packageTests",
            dependencies: [
                "Rebrickable.package",
            ]
        ),
    ]
)
