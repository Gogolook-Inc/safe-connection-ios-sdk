// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "SafeConnection",
    platforms: [
        .iOS("15.5"),
    ],
    products: [
        .library(name: "SafeConnection", targets: ["SafeConnection_Aggregation"]),
    ],
    dependencies: [
//      .package(url: "https://github.com/Moya/Moya", from: "15.0.3"),
//      .package(url: "https://github.com/marmelroy/PhoneNumberKit", from: "4.1.3"),
//      .package(url: "https://github.com/realm/realm-swift.git", exact: "10.54.5"), // Removed for testing
//      .package(url: "https://github.com/SimplyDanny/SwiftLintPlugins", from: "0.58.2"),
//       .package(url: "https://github.com/ZipArchive/ZipArchive", from: "2.6.0"),
    ],
    targets: [
        .binaryTarget(
            name: "SafeConnection",
            url: "https://github.com/Gogolook-Inc/safe-connection-ios-sdk/releases/download/0.5.12/SafeConnection.xcframework.zip",
            checksum: "b6ddcab7c23fa4b57323cbb2773dc3d18127d7b77cda440fb234dd2a3e505c68"
        ),
        .target(
            name: "SafeConnection_Aggregation",
            dependencies: [
                .target(name: "SafeConnection"),
                //.product(name: "Moya", package: "Moya"),
                //.product(name: "PhoneNumberKit", package: "PhoneNumberKit"),
                // .product(name: "RealmSwift", package: "realm-swift"), // Removed for testing
                //.product(name: "ZipArchive", package: "ZipArchive"),
            ],
        )
    ]
)