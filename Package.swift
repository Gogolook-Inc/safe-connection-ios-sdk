// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "SafeConnection",
    products: [
        .library(name: "SafeConnection", targets: ["SafeConnection"]),
    ],
    dependencies: [
	.package(url: "https://github.com/Moya/Moya", .upToNextMajor(from: "15.0.0")),
        .package(url: "https://github.com/realm/realm-swift.git", .exact("10.54.5")),
    ],
    targets: [
        .binaryTarget(
            name: "SafeConnection",
            url: "https://github.com/Gogolook-Inc/safe-connection-ios-sdk/releases/download/0.3.10/SafeConnection.xcframework.zip",
            checksum: "e9c1ae9278779ea326e69ce4a9c719608da7652a7e74212c619977ca80cd8146"
        ),
    ],
)
