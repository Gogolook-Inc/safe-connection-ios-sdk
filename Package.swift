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
            url: "https://github.com/Gogolook-Inc/safe-connection-ios-sdk/releases/download/0.3.3/SafeConnection.xcframework.zip",
            checksum: "28265b35f1d9a7bd4443cb4b3bac82a214017931b58e76365719aa6c33fd472e"
        ),
    ]
)