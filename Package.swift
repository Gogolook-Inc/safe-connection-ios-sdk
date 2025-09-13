// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "SafeConnection",
    platforms: [
        .iOS("15.5"),
    ],
    products: [
        .library(name: "SafeConnection", targets: ["SafeConnection"]),
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
            name: "SafeConnectionBinary",
            url: "https://github.com/Gogolook-Inc/safe-connection-ios-sdk/releases/download/0.5.9/SafeConnection.xcframework.zip",
            checksum: "e0c839c66de6fc94d0ab4af55f591301dcd21b87ad5171febe24616a41949bfc"
        ),
        .target(
            name: "SafeConnection",
            dependencies: [
                .target(name: "SafeConnectionBinary"),
                .product(name: "Moya", package: "Moya"),
                .product(name: "PhoneNumberKit-Dynamic", package: "PhoneNumberKit"),
                // .product(name: "RealmSwift", package: "realm-swift"), // Removed for testing
                .product(name: "ZipArchive", package: "ZipArchive"),
            ],
        )
    ]
)