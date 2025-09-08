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
            url: "https://github.com/Gogolook-Inc/safe-connection-ios-sdk/releases/download/0.3.0/SafeConnection.xcframework.zip",
            checksum: "ee78920722766c1826a138e3ead3171694eec41d342c232f9e0cc9c163947335"
        ),
    ]
)