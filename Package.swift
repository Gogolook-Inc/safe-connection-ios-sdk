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
            checksum: "5608a7c9e4ec8535327999c444f99fb678480f473272cfbe394a5116be21dbe6"
        ),
    ]
)