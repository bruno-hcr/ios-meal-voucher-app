// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MealVoucherList",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "MealVoucherList",
            targets: ["MealVoucherList"]
        ),
        .library(
            name: "MealVoucherListInterface",
            targets: ["MealVoucherListInterface"]
        )
    ],
    dependencies: [
        .package(path: "./Components"),
        .package(path: "./Network"),
        .package(path: "./RouterService"),
        .package(url: "https://github.com/onevcat/Kingfisher.git", exact: "7.0.0")
    ],
    targets: [
        .target(
            name: "MealVoucherList",
            dependencies: [
                "Components",
                "MealVoucherListInterface",
                "Kingfisher",
                .product(name: "NetworkInterface", package: "Network"),
                .product(name: "RouterServiceInterface", package: "RouterService")
            ]
        ),
        .target(
            name: "MealVoucherListInterface",
            dependencies: [
                .product(name: "RouterServiceInterface", package: "RouterService")
            ]
        ),
        .testTarget(
            name: "MealVoucherListTests",
            dependencies: ["MealVoucherList"]
        )
    ]
)
