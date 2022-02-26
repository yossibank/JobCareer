// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "Firebase",
    products: [
        .library(
            name: "Firebase",
            targets: [
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
    targets: [
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
        )
    ],
    cxxLanguageStandard: .cxx14
)
