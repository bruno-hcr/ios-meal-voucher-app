// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MealVoucherDetail",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "MealVoucherDetail",
            targets: ["MealVoucherDetail"]
        ),
        .library(
            name: "MealVoucherDetailInterface",
            targets: ["MealVoucherDetailInterface"]
        )
    ],
    dependencies: [
        .package(path: "./CommonAssets"),
        .package(path: "./Components"),
        .package(path: "./ImageFetcher"),
        .package(path: "./RouterService")
    ],
    targets: [
        .target(
            name: "MealVoucherDetail",
            dependencies: [
                "CommonAssets",
                "Components",
                "MealVoucherDetailInterface",
                .product(name: "ImageFetcherInterface", package: "ImageFetcher"),
                .product(name: "RouterServiceInterface", package: "RouterService")
            ]
        ),
        .target(
            name: "MealVoucherDetailInterface",
            dependencies: [
                "CommonAssets",
                .product(name: "RouterServiceInterface", package: "RouterService")
            ]
        ),
        .testTarget(
            name: "MealVoucherDetailTests",
            dependencies: ["MealVoucherDetail"]
        )
    ]
)
