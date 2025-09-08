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
            checksum: "2040e897fbaf2d1cf640fa216677afaf5293a79bea3fc9506b23271d9cda4686"
        ),
    ]
)