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
            checksum: "0347a4b7d560a5f92e441b9b0b5671cb586202e688ce9b73dc27192d6ec3c930"
        ),
    ]
)