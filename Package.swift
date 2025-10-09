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
            url: "https://github.com/Gogolook-Inc/safe-connection-ios-sdk/releases/download/0.5.25/SafeConnection.xcframework.zip",
            checksum: "f81ebabc71bb04b2d880b633814e4eca7a9b5c96bd2b41ec772c52b250bd857b"
        ),
    ]
)