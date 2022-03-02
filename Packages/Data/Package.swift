// swift-tools-version:5.5

import PackageDescription

let utilityDependencies: [Target.Dependency] = [
    "Utility"
]

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

let firebasePerformanceDependencies: [Target.Dependency] = [
    "FirebaseABTesting",
    "FirebasePerformance",
    "FirebaseRemoteConfig"
]

let firebaseMessagingDependencies: [Target.Dependency] = [
    "FirebaseMessaging"
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
        )
    ],
    targets: [
        .target(
            name: "Data",
            dependencies: utilityDependencies
                + firebaseAnalyticsDependencies
                + firebaseCrashlyticsDependencies
                + firebaseAuthDependencies
                + firebasePerformanceDependencies
                + firebaseFirestoreDependencies
            ,
            linkerSettings: [
                .unsafeFlags(["-ObjC"])
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
        ),
        .binaryTarget(
            name: "FirebaseAnalytics",
            path: "./Frameworks/Firebase/FirebaseAnalytics/FirebaseAnalytics.xcframework"
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
            name: "FirebaseInstallations",
            path: "./Frameworks/Firebase/FirebaseAnalytics/FirebaseInstallations.xcframework"
        ),
        .binaryTarget(
            name: "GoogleAppMeasurement",
            path: "./Frameworks/Firebase/FirebaseAnalytics/GoogleAppMeasurement.xcframework"
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
            name: "nanopb",
            path: "./Frameworks/Firebase/FirebaseAnalytics/nanopb.xcframework"
        ),
        .binaryTarget(
            name: "PromisesObjC",
            path: "./Frameworks/Firebase/FirebaseAnalytics/PromisesObjC.xcframework"
        ),
        .binaryTarget(
            name: "FirebaseAuth",
            path: "./Frameworks/Firebase/FirebaseAuth/FirebaseAuth.xcframework"
        ),
        .binaryTarget(
            name: "GTMSessionFetcher",
            path: "./Frameworks/Firebase/FirebaseAuth/GTMSessionFetcher.xcframework"
        ),
        .binaryTarget(
            name: "FirebaseCrashlytics",
            path: "./Frameworks/Firebase/FirebaseCrashlytics/FirebaseCrashlytics.xcframework"
        ),
        .binaryTarget(
            name: "FirebaseABTesting",
            path: "./Frameworks/Firebase/FirebasePerformance/FirebaseABTesting.xcframework"
        ),
        .binaryTarget(
            name: "FirebasePerformance",
            path: "./Frameworks/Firebase/FirebasePerformance/FirebasePerformance.xcframework"
        ),
        .binaryTarget(
            name: "FirebaseRemoteConfig",
            path: "./Frameworks/Firebase/FirebasePerformance/FirebaseRemoteConfig.xcframework"
        ),
        .binaryTarget(
            name: "FirebaseMessaging",
            path: "./Frameworks/Firebase/FirebaseMessaging/FirebaseMessaging.xcframework"
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
            name: "FirebaseFirestore",
            path: "./Frameworks/Firebase/FirebaseFirestore/FirebaseFirestore.xcframework"
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
            name: "leveldb-library",
            path: "./Frameworks/Firebase/FirebaseFirestore/leveldb-library.xcframework"
        )
    ]
)
