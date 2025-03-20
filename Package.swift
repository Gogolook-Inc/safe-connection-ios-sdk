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
            url: "https://github.com/Gogolook-Inc/safe-connection-ios-sdk/releases/download/0.1.0/SafeConnection.xcframework.zip",
            checksum: "d84022bb63fc7b6e1b8fc4c2cd9e57ba829aeacf298dda90800c503fd64899e4"
        ),
    ]
)