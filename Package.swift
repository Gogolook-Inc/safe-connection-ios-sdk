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
            url: "https://github.com/Gogolook-Inc/safe-connection-ios-sdk/releases/download/0.2.5/SafeConnection.xcframework.zip",
            checksum: "b29141d30eb4c99aa827bf8ce6faf86cf304a4df31dd3dc9609f0f2f9df6e15e"
        ),
    ]
)