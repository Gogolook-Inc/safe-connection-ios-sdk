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
        .package(url: "https://github.com/realm/realm-swift.git", exact: "10.54.5"),
//      .package(url: "https://github.com/SimplyDanny/SwiftLintPlugins", from: "0.58.2"),
        .package(url: "https://github.com/ZipArchive/ZipArchive", from: "2.6.0"),
    ],
    targets: [
        .binaryTarget(
            name: "SafeConnectionBinary",
            url: "https://github.com/Gogolook-Inc/safe-connection-ios-sdk/releases/download/0.5.8/SafeConnection.xcframework.zip",
            checksum: "8e18a4b8dbe95665fa22f5d7bd41d5ec24d7bd7399637cdbdeb600acb63cf910"
        ),
        .target(
            name: "SafeConnection",
            dependencies: [
                .target(name: "SafeConnectionBinary"),
                .product(name: "Moya", package: "Moya"),
                .product(name: "PhoneNumberKit-Dynamic", package: "PhoneNumberKit"),
                .product(name: "RealmSwift", package: "realm-swift"),
                .product(name: "ZipArchive", package: "ZipArchive"),
            ],
        )
    ]
)