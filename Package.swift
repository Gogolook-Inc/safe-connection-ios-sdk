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
            url: "https://github.com/Gogolook-Inc/safe-connection-ios-sdk/releases/download/0.2.4/SafeConnection.xcframework.zip",
            checksum: "b58dc7259518d1d0a53b3c421b4fe73d2d35778f06d5d7b810cc2123fff67b0e"
        ),
    ]
)