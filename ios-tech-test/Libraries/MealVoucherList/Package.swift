// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MealVoucherList",
    products: [
        .library(
            name: "MealVoucherList",
            targets: ["MealVoucherList"]
        ),
    ],
    dependencies: [
        .package(path: "./Components"),
        .package(path: "./Network")
    ],
    targets: [
        .target(
            name: "MealVoucherList",
            dependencies: [
                "Components",
                "Network"
            ]
        ),
        .testTarget(
            name: "MealVoucherListTests",
            dependencies: ["MealVoucherList"]
        ),
    ]
)
