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
        .package(path: "./Components"),
        .package(path: "./MealVoucherList"),
        .package(path: "./RouterService")
    ],
    targets: [
        .target(
            name: "MealVoucherDetail",
            dependencies: [
                "Components",
                "MealVoucherDetailInterface",
                .product(name: "RouterServiceInterface", package: "RouterService")
            ]
        ),
        .target(
            name: "MealVoucherDetailInterface",
            dependencies: [
                .product(name: "MealVoucherListInterface", package: "MealVoucherList"),
                .product(name: "RouterServiceInterface", package: "RouterService")
            ]
        ),
        .testTarget(
            name: "MealVoucherDetailTests",
            dependencies: ["MealVoucherDetail"]
        )
    ]
)
