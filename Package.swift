// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "SafeConnection",
    products: [
        .library(name: "SafeConnection", targets: ["SafeConnection"]),
    ],
    dependencies: [
        .package(url: "https://github.com/realm/realm-swift.git", exact: "10.54.5"),
    ],
    targets: [
        .binaryTarget(
            name: "SafeConnectionBinary",
            url: "https://github.com/Gogolook-Inc/safe-connection-ios-sdk/releases/download/0.5.3/SafeConnection.xcframework.zip",
            checksum: "4e0b1b58737ef63ab5fc462f512e353cd195f198ec1bc4c6440b5a335d365c66"
        ),
        .target(
            name: "SafeConnection",
            dependencies: [
                .target(name: "SafeConnectionBinary"),
                .product(name: "RealmSwift", package: "realm-swift")
            ]
        )
    ]
)