// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MealVoucherDetail",
    products: [
        .library(
            name: "MealVoucherDetail",
            targets: ["MealVoucherDetail"]
        ),
    ],
    dependencies: [
        .package(path: "./Components")
    ],
    targets: [
        .target(
            name: "MealVoucherDetail",
            dependencies: [
                "Components"
            ]
        ),
        .testTarget(
            name: "MealVoucherDetailTests",
            dependencies: ["MealVoucherDetail"]
        ),
    ]
)
