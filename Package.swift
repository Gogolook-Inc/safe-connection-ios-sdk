// swift-tools-version: 5.10

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
            url: "https://github.com/Gogolook-Inc/safe-connection-ios-sdk/releases/download/0.5.20/SafeConnection.xcframework.zip",
            checksum: "776321fc56bf64638e6c13024d030a1f5c8e8e99064fbd616b477849d873ed69"
        ),
    ]
)