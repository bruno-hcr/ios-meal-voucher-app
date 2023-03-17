// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RouterService",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "RouterService",
            targets: ["RouterService"]
        ),
        .library(
            name: "RouterServiceInterface",
            targets: ["RouterServiceInterface"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "RouterService",
            dependencies: ["RouterServiceInterface"]
        ),
        .target(
            name: "RouterServiceInterface",
            dependencies: []
        ),
        .testTarget(
            name: "RouterServiceTests",
            dependencies: ["RouterService"]
        )
    ]
)
