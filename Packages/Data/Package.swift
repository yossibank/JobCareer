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
                "Data",
                "FirebaseAnalytics",
                "FirebaseAuth",
                "FirebaseCore",
                "FirebaseCoreDiagnostics",
                "FirebaseCrashlytics",
                "FirebaseInstallations",
                "GoogleAppMeasurement",
                "GoogleAppMeasurementIdentitySupport",
                "GoogleDataTransport",
                "GoogleUtilities",
                "GTMSessionFetcher",
                "nanopb",
                "PromisesObjC"
            ]
        )
    ],
    dependencies: [
        .package(
            url: "../Utility",
            from: "1.0.0"
        )
    ],
    targets: [
        .target(
            name: "Data",
            dependencies: [
                .product(name: "Utility", package: "Utility")
            ],
            resources: [
                .process("TestData")
            ]
        ),
        .binaryTarget(
            name: "FirebaseAnalytics",
            path: "artifacts/FirebaseAnalytics.xcframework"
        ),
        .binaryTarget(
            name: "FirebaseAuth",
            path: "artifacts/FirebaseAuth.xcframework"
        ),
        .binaryTarget(
            name: "FirebaseCore",
            path: "artifacts/FirebaseCore.xcframework"
        ),
        .binaryTarget(
            name: "FirebaseCoreDiagnostics",
            path: "artifacts/FirebaseCoreDiagnostics.xcframework"
        ),
        .binaryTarget(
            name: "FirebaseCrashlytics",
            path: "artifacts/FirebaseCrashlytics.xcframework"
        ),
        .binaryTarget(
            name: "FirebaseInstallations",
            path: "artifacts/FirebaseInstallations.xcframework"
        ),
        .binaryTarget(
            name: "GoogleAppMeasurement",
            path: "artifacts/GoogleAppMeasurement.xcframework"
        ),
        .binaryTarget(
            name: "GoogleAppMeasurementIdentitySupport",
            path: "artifacts/GoogleAppMeasurementIdentitySupport.xcframework"
        ),
        .binaryTarget(
            name: "GoogleDataTransport",
            path: "artifacts/GoogleDataTransport.xcframework"
        ),
        .binaryTarget(
            name: "GoogleUtilities",
            path: "artifacts/GoogleUtilities.xcframework"
        ),
        .binaryTarget(
            name: "GTMSessionFetcher",
            path: "artifacts/GTMSessionFetcher.xcframework"
        ),
        .binaryTarget(
            name: "nanopb",
            path: "artifacts/nanopb.xcframework"
        ),
        .binaryTarget(
            name: "PromisesObjC",
            path: "artifacts/PromisesObjC.xcframework"
        ),
        .testTarget(
            name: "DataTests",
            dependencies: [
                "Data"
            ]
        )
    ],
    cxxLanguageStandard: .cxx14
)
