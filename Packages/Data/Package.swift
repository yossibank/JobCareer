// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "Data",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "Data",
            targets: [
                "Data"
            ]
        )
    ],
    dependencies: [
        .package(
            url: "../Utility",
            from: "1.0.0"
        ),
        .package(
            name: "Firebase",
            url: "https://github.com/firebase/firebase-ios-sdk.git",
            from: "8.9.0"
        )
    ],
    targets: [
        .target(
            name: "Data",
            dependencies: [
                .product(name: "Utility", package: "Utility"),
                .product(name: "FirebaseAuth", package: "Firebase")
            ],
            resources: [
                .process("TestData")
            ]
        ),
        .testTarget(
            name: "DataTests",
            dependencies: [
                "Data"
            ]
        )
    ]
)
