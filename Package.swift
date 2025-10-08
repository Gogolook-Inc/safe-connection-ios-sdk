// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "SafeConnection",
    platforms: [
        .iOS(.v16),
    ],
    products: [
        .library(name: "SafeConnection", targets: ["SafeConnection_Aggregation"]),
    ],
    dependencies: [
        .package(url: "https://github.com/realm/realm-swift.git", exact: "10.54.5"),
    ],
    targets: [
        .target(
            name: "SafeConnection_Aggregation",
            dependencies: [
                .target(name: "SafeConnection"),
                .product(name: "RealmSwift", package: "realm-swift"),
            ],
        ),
        .binaryTarget(
            name: "SafeConnection",
            url: "https://github.com/Gogolook-Inc/safe-connection-ios-sdk/releases/download/0.5.21/SafeConnection.xcframework.zip",
            checksum: "127437298bc3610c1781302c6f7f2b13065358152c5854e0aa1292f52c9c06b5"
        ),
    ]
)