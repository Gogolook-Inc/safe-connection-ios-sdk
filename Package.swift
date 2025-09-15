// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "SafeConnection",
    platforms: [
        .iOS(.v16),
    ],
    products: [
        .library(name: "SafeConnection", targets: ["SafeConnection"]),
    ],
    dependencies: [
        .package(url: "https://github.com/realm/realm-swift.git", exact: "10.54.5"),
    ],
    targets: [
        .target(
            name: "SafeConnection",
            dependencies: [
                .target(name: "SafeConnectionBinary"),
                .product(name: "RealmSwift", package: "realm-swift"),
            ],
        ),
        .binaryTarget(
            name: "SafeConnectionBinary",
            url: "https://github.com/Gogolook-Inc/safe-connection-ios-sdk/releases/download/0.5.18/SafeConnection.xcframework.zip",
            checksum: "ba30269c4bac998536abd77963e692da1f5c145f36232490da71e01f3640a596"
        ),
    ]
)