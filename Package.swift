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
            url: "https://github.com/Gogolook-Inc/safe-connection-ios-sdk/releases/download/0.4.0/SafeConnection.xcframework.zip",
            checksum: "7d2b2b05d198980a688ddfb0b61ddc729cb16012a3f30e59c28f1bf886a48224"
        ),
    ]
)