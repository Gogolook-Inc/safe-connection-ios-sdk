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
            url: "https://github.com/Gogolook-Inc/safe-connection-ios-sdk/releases/download/0.2.3/SafeConnection.xcframework.zip",
            checksum: "1d393452b1accbd8d7b1af3272bf31e93dad624fe1236e0a340982fe41ece294"
        ),
    ]
)