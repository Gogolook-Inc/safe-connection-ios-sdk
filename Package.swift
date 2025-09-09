// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "SafeConnection",
    products: [
        .library(name: "SafeConnection", targets: ["SafeConnection"]),
    ],
    dependencies: [
	.package(url: "https://github.com/Moya/Moya", .upToNextMajor(from: "15.0.0")),
        .package(url: "https://github.com/realm/realm-swift.git", .exact: "10.54.5"),
    ],
    targets: [
        .binaryTarget(
            name: "SafeConnection",
            url: "https://github.com/Gogolook-Inc/safe-connection-ios-sdk/releases/download/0.3.9/SafeConnection.xcframework.zip",
            checksum: "e0c3b4a4fa33926ffe4837df8ef6ecef47e954976eeac1a3bec0bd105b85181c"
        ),
    ],
)
