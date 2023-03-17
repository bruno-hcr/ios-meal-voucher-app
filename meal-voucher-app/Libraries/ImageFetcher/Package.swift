// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ImageFetcher",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "ImageFetcherInterface",
            targets: ["ImageFetcherInterface"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "ImageFetcherInterface",
            dependencies: []
        )
    ]
)
