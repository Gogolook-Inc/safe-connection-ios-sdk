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
            url: "https://github.com/Gogolook-Inc/safe-connection-ios-sdk/releases/download/0.2.6/SafeConnection.xcframework.zip",
            checksum: "873a5bb8a26aa634f7019fcec8b64da00e706b20bf6e1939b93efc559bfe016a"
        ),
    ]
)