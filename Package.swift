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
            url: "https://github.com/Gogolook-Inc/safe-connection-ios-sdk/releases/download/0.3.6/SafeConnection.xcframework.zip",
            checksum: "f67e9dec686ce10559c80027d077e2bdbf4bd1bca9eccf14afe659a1f3119ccc"
        ),
    ],
    dependencies: [
	.package(url: "https://github.com/Moya/Moya", upToNextMajor(from: "15.0.0")),
        .package(url: "https://github.com/realm/realm-swift.git", exact:("10.54.5")),
    ],
)
