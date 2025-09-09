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
            url: "https://github.com/Gogolook-Inc/safe-connection-ios-sdk/releases/download/0.3.5/SafeConnection.xcframework.zip",
            checksum: "2e76c9f77325fba7231a9816cf75aff0d81df22578ac1855f4ce3ae53a14c828"
        ),
    ],
    dependencies: [
	.package(url: "https://github.com/Moya/Moya", upToNextMajor(from: "15.0.0"),
        .package(url: "https://github.com/realm/realm-swift.git", exact:("10.54.5"),
    ]
)
