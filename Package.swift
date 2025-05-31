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
            url: "https://github.com/Gogolook-Inc/safe-connection-ios-sdk/releases/download/0.2.2/SafeConnection.xcframework.zip",
            checksum: "21baf308ee2a6f6388204feb0f6750e4773cb58e9163fc2215900d5dc4d0fb62"
        ),
    ]
)