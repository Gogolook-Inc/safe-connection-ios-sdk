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
            url: "https://github.com/Gogolook-Inc/safe-connection-ios-sdk/releases/download/0.4.1/SafeConnection.xcframework.zip",
            checksum: "5b2b72fdd5765fa18fae9025cb05bd6297fc18292adde8e88174b42b29c2d86c"
        ),
    ]
)