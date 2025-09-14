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
        .package(url: "https://github.com/Moya/Moya", exact: "15.0.3"),
        .package(url: "https://github.com/marmelroy/PhoneNumberKit", exact: "4.1.4"),
//      .package(url: "https://github.com/realm/realm-swift.git", exact: "10.54.5"), // Removed for testing
//      .package(url: "https://github.com/SimplyDanny/SwiftLintPlugins", exact: "0.58.2"),
        .package(url: "https://github.com/ZipArchive/ZipArchive", exact: "2.6.0"),
    ],
    targets: [
        .binaryTarget(
            name: "SafeConnection",
            url: "https://github.com/Gogolook-Inc/safe-connection-ios-sdk/releases/download/0.5.14/SafeConnection.xcframework.zip",
            checksum: "11b64beb0b76ebbaced89a78406dc5b5d4ce14fde60ee4e1a6d19eb9fd2232d9"
        ),
        .target(
            name: "SafeConnection_Aggregation",
            dependencies: [
                .target(name: "SafeConnection"),
                .product(name: "Moya", package: "Moya"),
                .product(name: "PhoneNumberKit-Dynamic", package: "PhoneNumberKit"),
//              .product(name: "RealmSwift", package: "realm-swift"), // Removed for testing
                .product(name: "ZipArchive", package: "ZipArchive"),
            ],
        )
    ]
)