// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CommonAssets",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "CommonAssets",
            targets: ["CommonAssets"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "CommonAssets",
            resources: [
                .process("Resources/Media.xcassets")
            ]
        )
    ]
)
