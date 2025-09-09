// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "SafeConnection",
    products: [
        .library(name: "SafeConnection", targets: ["SafeConnection"]),
    ],
    targets: [
        .binaryTarget(
            name: "SafeConnection",
            url: "https://github.com/Gogolook-Inc/safe-connection-ios-sdk/releases/download/0.4.3/SafeConnection.xcframework.zip",
            checksum: "43fce9f5598583953153b98aaf1f6a444c6e89c023271a341fc9d5d9083f38da"
        ),
    ]
)