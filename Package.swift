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
            url: "https://github.com/Gogolook-Inc/safe-connection-ios-sdk/releases/download/0.3.7/SafeConnection.xcframework.zip",
            checksum: "fab74c8d74ed9e87fe1188def3b30566c24de5527c60d8c796f3de19c0861d9d"
        ),
    ],
    dependencies: [
	.package(url: "https://github.com/Moya/Moya", .upToNextMajor(from: "15.0.0")),
        .package(url: "https://github.com/realm/realm-swift.git", .exact:("10.54.5")),
    ],
)
