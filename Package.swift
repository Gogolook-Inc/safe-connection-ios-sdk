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
            url: "https://github.com/Gogolook-Inc/safe-connection-ios-sdk/releases/download/0.3.2/SafeConnection.xcframework.zip",
            checksum: "3788bbf874ad31ec5e516615d498f2f2ff021010d6e7cc482eff6f80cb86e13e"
        ),
    ]
)