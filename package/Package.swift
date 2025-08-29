// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Rebrickable.package",
    platforms: [
        .macOS(.v14), .iOS(.v17), .tvOS(.v17), .watchOS(.v10)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Rebrickable.package",
            targets: ["Rebrickable.package"]
        ),
    ],
    dependencies: [
        // Swifter is used in tests
        .package(url: "https://github.com/httpswift/swifter.git", from: "1.5.0")
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
                .product(name: "Swifter", package: "swifter")
            ]
        ),
    ]
)
