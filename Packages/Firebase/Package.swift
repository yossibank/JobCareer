// swift-tools-version:5.5

import PackageDescription

let firebaseAnalyticsDependencies: [Target.Dependency] = [
    "FirebaseAnalytics",
    "FirebaseCore",
    "FirebaseCoreDiagnostics",
    "FirebaseInstallations",
    "GoogleAppMeasurement",
    "GoogleDataTransport",
    "GoogleUtilities",
    "nanopb",
    "PromisesObjC"
]

let firebaseCrashlyticsDependencies: [Target.Dependency] = [
    "FirebaseCrashlytics"
]

let firebaseAuthDependencies: [Target.Dependency] = [
    "FirebaseAuth",
    "GTMSessionFetcher"
]

let firebaseFirestoreDependencies: [Target.Dependency] = [
    "BoringSSL-GRPC",
    "FirebaseFirestore",
    "abseil",
    "gRPC-C++",
    "gRPC-Core",
    "leveldb-library"
]

let package = Package(
    name: "Firebase",
    products: [
        .library(
            name: "Firebase",
            targets: [
                "Firebase"
            ]
        )
    ],
    targets: [
        .target(
            name: "Firebase",
            dependencies: firebaseAnalyticsDependencies
                + firebaseCrashlyticsDependencies
                + firebaseAuthDependencies
                + firebaseFirestoreDependencies
        ),
        .binaryTarget(
            name: "abseil",
            path: "./Frameworks/Firebase/FirebaseFirestore/abseil.xcframework"
        ),
        .binaryTarget(
            name: "BoringSSL-GRPC",
            path: "./Frameworks/Firebase/FirebaseFirestore/BoringSSL-GRPC.xcframework"
        ),
        .binaryTarget(
            name: "FirebaseAnalytics",
            path: "./Frameworks/Firebase/FirebaseAnalytics/FirebaseAnalytics.xcframework"
        ),
        .binaryTarget(
            name: "FirebaseAuth",
            path: "./Frameworks/Firebase/FirebaseAuth/FirebaseAuth.xcframework"
        ),
        .binaryTarget(
            name: "FirebaseCore",
            path: "./Frameworks/Firebase/FirebaseAnalytics/FirebaseCore.xcframework"
        ),
        .binaryTarget(
            name: "FirebaseCoreDiagnostics",
            path: "./Frameworks/Firebase/FirebaseAnalytics/FirebaseCoreDiagnostics.xcframework"
        ),
        .binaryTarget(
            name: "FirebaseCrashlytics",
            path: "./Frameworks/Firebase/FirebaseCrashlytics/FirebaseCrashlytics.xcframework"
        ),
        .binaryTarget(
            name: "FirebaseFirestore",
            path: "./Frameworks/Firebase/FirebaseFirestore/FirebaseFirestore.xcframework"
        ),
        .binaryTarget(
            name: "FirebaseInstallations",
            path: "./Frameworks/Firebase/FirebaseAnalytics/FirebaseInstallations.xcframework"
        ),
        .binaryTarget(
            name: "GoogleAppMeasurement",
            path: "./Frameworks/Firebase/FirebaseAnalytics/GoogleAppMeasurement.xcframework"
        ),
        .binaryTarget(
            name: "GoogleAppMeasurementIdentitySupport",
            path: "./Frameworks/Firebase/FirebaseAnalytics/GoogleAppMeasurementIdentitySupport.xcframework"
        ),
        .binaryTarget(
            name: "GoogleDataTransport",
            path: "./Frameworks/Firebase/FirebaseAnalytics/GoogleDataTransport.xcframework"
        ),
        .binaryTarget(
            name: "GoogleUtilities",
            path: "./Frameworks/Firebase/FirebaseAnalytics/GoogleUtilities.xcframework"
        ),
        .binaryTarget(
            name: "gRPC-C++",
            path: "./Frameworks/Firebase/FirebaseFirestore/gRPC-C++.xcframework"
        ),
        .binaryTarget(
            name: "gRPC-Core",
            path: "./Frameworks/Firebase/FirebaseFirestore/gRPC-Core.xcframework"
        ),
        .binaryTarget(
            name: "GTMSessionFetcher",
            path: "./Frameworks/Firebase/FirebaseAuth/GTMSessionFetcher.xcframework"
        ),
        .binaryTarget(
            name: "leveldb-library",
            path: "./Frameworks/Firebase/FirebaseFirestore/leveldb-library.xcframework"
        ),
        .binaryTarget(
            name: "nanopb",
            path: "./Frameworks/Firebase/FirebaseAnalytics/nanopb.xcframework"
        ),
        .binaryTarget(
            name: "PromisesObjC",
            path: "./Frameworks/Firebase/FirebaseAnalytics/PromisesObjC.xcframework"
        )
    ]
)
