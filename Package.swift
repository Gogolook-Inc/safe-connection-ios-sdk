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
            url: "https://github.com/Gogolook-Inc/safe-connection-ios-sdk/releases/download/0.3.1/SafeConnection.xcframework.zip",
            checksum: "4138aec8dde50ba3ce255918dc4ca1a30da16e2ee96dd15470c1b3340b5bed56"
        ),
    ]
)