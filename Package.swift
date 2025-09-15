// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "SafeConnection",
    platforms: [
        .iOS(.v18.5),
    ],
    products: [
        .library(name: "SafeConnection", targets: ["SafeConnection"]),
    ],
    dependencies: [
        .package(url: "https://github.com/realm/realm-swift.git", exact: "10.54.5"),
    ],
    targets: [
        .target(
            name: "SafeConnection",
            dependencies: [
                .target(name: "SafeConnectionBinary"),
                .product(name: "RealmSwift", package: "realm-swift"),
            ],
        ),
        .binaryTarget(
            name: "SafeConnectionBinary",
            url: "https://github.com/Gogolook-Inc/safe-connection-ios-sdk/releases/download/0.5.17/SafeConnection.xcframework.zip",
            checksum: "2b19a069e72fca84159e026cf5a51b550af9e39fa622316c632645c8ba46aa20"
        ),
    ]
)