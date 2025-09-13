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
        .package(url: "https://github.com/Moya/Moya", from: "15.0.3"),
        .package(url: "https://github.com/marmelroy/PhoneNumberKit", from: "4.1.3"),
        // .package(url: "https://github.com/realm/realm-swift.git", exact: "10.54.5"), // Removed for testing
//      .package(url: "https://github.com/SimplyDanny/SwiftLintPlugins", from: "0.58.2"),
        .package(url: "https://github.com/ZipArchive/ZipArchive", from: "2.6.0"),
    ],
    targets: [
        .binaryTarget(
            name: "SafeConnection",
            url: "https://github.com/Gogolook-Inc/safe-connection-ios-sdk/releases/download/0.5.10/SafeConnection.xcframework.zip",
            checksum: "33e82ab8c6e2a6b1caf3256ed3f78e88a3632769fd5a1778b90686828ee620db"
        ),
        .target(
            name: "SafeConnection_Aggregation",
            dependencies: [
                .target(name: "SafeConnection"),
                .product(name: "Moya", package: "Moya"),
                .product(name: "PhoneNumberKit-Dynamic", package: "PhoneNumberKit"),
                // .product(name: "RealmSwift", package: "realm-swift"), // Removed for testing
                .product(name: "ZipArchive", package: "ZipArchive"),
            ],
        )
    ]
)