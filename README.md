# SafeConnection

SafeConnection iOS SDK

- [Usage](#Usage)
- [Installation](#Installation)
- [Required](#Required)

## Usage
``` swift
import SafeConnection
```

## Installation
### Swift Package Manager
#### Xcode Project
1. File > Swift Packages > Add Package Dependency
2. Add https://github.com/Gogolook-Inc/safe-connection-ios-sdk
#### Package.swift
```swift
// ...
// Add SafeConnection as a dependency
dependencies: [
    .package(url: "https://github.com/Gogolook-Inc/safe-connection-ios-sdk", .upToNextMajor(from: "0.5.9"))
]
// ...
// Add SafeConnection to your target
.product(name: "SafeConnection", package: "SafeConnection")
```
### CocoaPods
``` ruby
pod "SafeConnection", :git => "https://github.com/Gogolook-Inc/safe-connection-ios-sdk", :tag => "0.5.9"
```

## Required
- iOS 16+
- Xcode 16.2+