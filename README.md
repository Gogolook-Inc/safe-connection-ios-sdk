# SafeConnection iOS SDK

SafeConnection is a powerful iOS SDK that provides phone number identification, spam call blocking, SMS filtering, and website security scanning features.

## Table of Contents

- [Requirements](#requirements)
- [Installation](#installation)
- [SDK Initialization](#sdk-initialization)
- [Features](#features)
  - [Number Search](#number-search)
  - [Offline Database](#offline-database)
  - [Personal Blocking](#personal-blocking)
  - [Personal Identification](#personal-identification)
  - [SMS Filtering](#sms-filtering)
  - [Safari URL Scanner](#safari-url-scanner)
- [Data Structures](#data-structures)
- [Error Handling](#error-handling)
- [Usage Limits](#usage-limits)

---

## Requirements

| Item | Minimum Version |
|------|-----------------|
| iOS | 16.0+ |
| Xcode | 16.2+ |

---

## Installation

### Swift Package Manager

#### Xcode Project Integration

1. In Xcode, select **File > Add Package Dependency**
2. Enter the package URL: `https://github.com/Gogolook-Inc/safe-connection-ios-sdk`

#### Package.swift Integration

```swift
// Add SafeConnection to dependencies
dependencies: [
    .package(url: "https://github.com/Gogolook-Inc/safe-connection-ios-sdk", .upToNextMajor(from: "0.5.26"))
]

// Add to target dependencies
.product(name: "SafeConnection", package: "SafeConnection")
```

### CocoaPods

Add to your `Podfile`:

```ruby
pod "SafeConnection", :git => "https://github.com/Gogolook-Inc/safe-connection-ios-sdk", :tag => "0.5.26"
```

---

## SDK Initialization

### 1. Create Configuration File

Create a `SafeConnectionSDK-Info.plist` file in your project with the following required parameters:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>ENVIRONMENT</key>
    <integer>0</integer>
    <key>APP_GROUP_ID</key>
    <string>group.com.yourcompany.yourapp</string>
    <key>LICENSE_ID</key>
    <string>YOUR_LICENSE_ID</string>
</dict>
</plist>
```

#### Configuration Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `ENVIRONMENT` | Integer | Yes | Runtime environment: `0` = Production, `1` = Sandbox, `2` = Staging |
| `APP_GROUP_ID` | String | Yes | App Group identifier for data sharing between main app and extensions |
| `LICENSE_ID` | String | Yes | License identifier, please contact Gogolook to obtain |

### 2. Initialize the SDK

Call `configure()` when your app launches:

```swift
import SafeConnection

@main
struct YourApp: App {
    init() {
        do {
            try SafeConnectionSDK.configure()
        } catch {
            print("SafeConnection SDK initialization failed: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```

#### Using Custom Configuration File Path

```swift
import SafeConnection

do {
    let plistURL = Bundle.main.url(forResource: "CustomConfig", withExtension: "plist")
    let options = try SafeConnectionSDK.Options(plistURL: plistURL)
    try SafeConnectionSDK.configure(options)
} catch {
    print("Initialization failed: \(error)")
}
```

> **Important**: The SDK must be initialized in **both** the main app and any extensions that use SafeConnection features. Each extension has its own process and requires separate initialization.

---

## Features

### Number Search

Query phone number information including name, business category, spam classification, and more.

#### API

```swift
func search(e164: String) async throws -> NumberInfo
```

#### Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `e164` | String | Yes | Phone number. Accepts multiple formats: `0912345678`, `886912345678`, or `+886912345678` are all valid inputs. |

#### Return Value

Returns a `NumberInfo` structure. See [NumberInfo](#numberinfo) for details.

#### Usage Example

```swift
import SafeConnection

let sdk = SafeConnectionSDK()

Task {
    do {
        let numberInfo = try await sdk.search(e164: "+886912345678")
        print("Name: \(numberInfo.name)")
        print("Business Category: \(numberInfo.businessCategory)")
        print("Spam Category: \(numberInfo.spamCategory)")
        print("Spam Level: \(numberInfo.spamLevel)")
    } catch {
        print("Search failed: \(error)")
    }
}
```

---

### Offline Database

Download and manage the offline number database for caller identification without network connectivity.

#### API

| Method | Description |
|--------|-------------|
| `downloadOfflineDatabaseIfOutdated() async throws -> String` | Download or update the offline database |
| `getCurrentCommonDbProfileString() throws -> String` | Get current database version |
| `getNextCommonDbProfileString() throws -> String` | Get next database version |
| `clearCommonDb(completion:) async throws` | Clear the offline database |
| `loadDbEntries(context:blockTopSpamNumbers:)` | Load database entries into CallKit (static method) |

#### Download/Update Database

```swift
let sdk = SafeConnectionSDK()

Task {
    do {
        let result = try await sdk.downloadOfflineDatabaseIfOutdated()
        print(result) // "Successfully updated database version to X" or "Current database version is X, is up to date."
    } catch {
        print("Download failed: \(error)")
    }
}
```

#### Get Database Version

```swift
do {
    let currentVersion = try sdk.getCurrentCommonDbProfileString()
    let nextVersion = try sdk.getNextCommonDbProfileString()
    print("Current version: \(currentVersion)")
    print("Next version: \(nextVersion)")
} catch {
    print("Failed to get version: \(error)")
}
```

#### Clear Database

```swift
Task {
    do {
        try await sdk.clearCommonDb(completion: { result in
            switch result {
            case .success:
                print("Database cleared successfully")
            case .failure(let error):
                print("Clear failed: \(error)")
            }
        })
    } catch {
        print("Clear operation failed: \(error)")
    }
}

// Or without completion handler
Task {
    do {
        try await sdk.clearCommonDb(completion: nil)
        print("Database cleared")
    } catch {
        print("Clear failed: \(error)")
    }
}
```

#### Load Database in Call Directory Extension

Create a Call Directory Extension target and implement `CallDirectoryHandler.swift`:

```swift
import CallKit
import SafeConnection

class CallDirectoryHandler: CXCallDirectoryProvider {
    
    // IMPORTANT: SDK must be initialized in the extension's init()
    override init() {
        super.init()
        do {
            try SafeConnectionSDK.configure()
        } catch {
            print("SDK initialization failed: \(error)")
        }
    }
    
    override func beginRequest(with context: CXCallDirectoryExtensionContext) {
        context.delegate = self
        
        // Load offline database entries
        SafeConnectionSDK.loadDbEntries(context: context, blockTopSpamNumbers: true)
        
        // IMPORTANT: Must call completeRequest() to finish the extension request
        context.completeRequest()
    }
}

extension CallDirectoryHandler: CXCallDirectoryExtensionContextDelegate {
    func requestFailed(for extensionContext: CXCallDirectoryExtensionContext, 
                       withError error: Error) {
        print("Request failed: \(error)")
    }
}
```

#### Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `context` | CXCallDirectoryExtensionContext | Yes | Extension context provided by CallKit |
| `blockTopSpamNumbers` | Bool | Yes | Whether to block high-risk spam numbers |

---

### Personal Blocking

Allow users to block specific phone numbers.

#### API

| Method | Description |
|--------|-------------|
| `blockNumber(number:) async -> Result<Void, Error>` | Block a phone number |
| `unblockNumber(number:) async -> Result<Void, Error>` | Unblock a phone number |
| `loadPersonalBlockingEntries(context:)` | Load blocking list into CallKit (static method) |

#### Block a Number

```swift
let sdk = SafeConnectionSDK()

Task {
    let result = await sdk.blockNumber(number: "+886912345678")
    switch result {
    case .success:
        print("Number blocked successfully")
    case .failure(let error):
        print("Block failed: \(error)")
    }
}
```

#### Unblock a Number

```swift
Task {
    let result = await sdk.unblockNumber(number: "+886912345678")
    switch result {
    case .success:
        print("Number unblocked successfully")
    case .failure(let error):
        print("Unblock failed: \(error)")
    }
}
```

#### Load Personal Blocking List in Call Directory Extension

```swift
import CallKit
import SafeConnection

class CallDirectoryHandler: CXCallDirectoryProvider {
    
    // IMPORTANT: SDK must be initialized in the extension's init()
    override init() {
        super.init()
        do {
            try SafeConnectionSDK.configure()
        } catch {
            print("SDK initialization failed: \(error)")
        }
    }
    
    override func beginRequest(with context: CXCallDirectoryExtensionContext) {
        context.delegate = self
        
        SafeConnectionSDK.loadPersonalBlockingEntries(context: context)
        
        // IMPORTANT: Must call completeRequest() to finish the extension request
        context.completeRequest()
    }
}

extension CallDirectoryHandler: CXCallDirectoryExtensionContextDelegate {
    func requestFailed(for extensionContext: CXCallDirectoryExtensionContext, 
                       withError error: Error) {
        print("Request failed: \(error)")
    }
}
```

#### Error Handling

The `blockNumber` and `unblockNumber` methods return `Result<Void, Error>`. Common error scenarios include:

| Error Scenario | Description |
|----------------|-------------|
| Maximum limit reached | Maximum blocking limit is 500 numbers |
| Number already exists | Number is already in the blocking list |
| Number not found | Number not found in the blocking list (for unblock) |
| Invalid number | The provided number format is invalid |

```swift
let result = await sdk.blockNumber(number: "+886912345678")
switch result {
case .success:
    print("Block successful")
case .failure(let error):
    print("Block failure: \(error)")
}
```

---

### Personal Identification

Store queried number information locally for caller identification display.

#### API

| Method | Description |
|--------|-------------|
| `loadPersonalIdentificationEntries(context:)` | Load identification list into CallKit (static method) |

#### Load Identification List in Call Directory Extension

```swift
import CallKit
import SafeConnection

class CallDirectoryHandler: CXCallDirectoryProvider {
    
    // IMPORTANT: SDK must be initialized in the extension's init()
    override init() {
        super.init()
        do {
            try SafeConnectionSDK.configure()
        } catch {
            print("SDK initialization failed: \(error)")
        }
    }
    
    override func beginRequest(with context: CXCallDirectoryExtensionContext) {
        context.delegate = self
        
        SafeConnectionSDK.loadPersonalIdentificationEntries(context: context)
        
        context.completeRequest()
    }
}

extension CallDirectoryHandler: CXCallDirectoryExtensionContextDelegate {
    func requestFailed(for extensionContext: CXCallDirectoryExtensionContext, 
                       withError error: Error) {
        print("Request failed: \(error)")
    }
}
```

> **Note**: When you use `search(e164:)` to query a number, the result is automatically saved to the personal identification database and will be displayed during incoming calls.

#### Identification Display Rules

The SDK automatically adds visual prefixes to caller identification labels:

| Scenario | Display Prefix | Description |
|----------|----------------|-------------|
| Spam numbers | ⚠️ | Warning indicator for spam |
| Whoscall verified | ✅ | Verified by Whoscall (Taiwan only) |
| Regular numbers | (none) | Standard display |

---

### SMS Filtering

Filter spam messages and automatically categorize suspicious messages to the junk folder.

#### API

| Method | Description |
|--------|-------------|
| `smsFiltering.enable() async throws` | Enable SMS filtering |
| `smsFiltering.disable() async throws` | Disable SMS filtering |
| `smsFiltering.lastFetchDate() throws -> Date?` | Get the last filter rules update time |
| `smsFiltering.handle(_:context:completion:)` | Handle SMS filtering requests |

#### Enable/Disable SMS Filtering

```swift
let sdk = SafeConnectionSDK()

// Enable
Task {
    do {
        try await sdk.smsFiltering.enable()
        print("SMS filtering enabled")
    } catch {
        print("Enable failed: \(error)")
    }
}

// Disable
Task {
    do {
        try await sdk.smsFiltering.disable()
        print("SMS filtering disabled")
    } catch {
        print("Disable failed: \(error)")
    }
}
```

#### Get Last Update Time

```swift
do {
    if let lastFetchDate = try sdk.smsFiltering.lastFetchDate() {
        print("Filter rules last updated: \(lastFetchDate)")
    } else {
        print("Filter rules not yet fetched")
    }
} catch {
    print("Failed to get update time: \(error)")
}
```

#### Handle Filtering Requests in Message Filter Extension

Create a Message Filter Extension target and implement:

```swift
import IdentityLookup
import SafeConnection

final class MessageFilterExtension: ILMessageFilterExtension {
    
    // Store SDK instance to reuse across requests
    let safeConnectionSDK: SafeConnectionSDK
    
    // IMPORTANT: SDK must be initialized in the extension's init()
    override init() {
        do {
            try SafeConnectionSDK.configure()
        } catch {
            print("SDK initialization failed: \(error)")
        }
        self.safeConnectionSDK = SafeConnectionSDK()
        super.init()
    }
}

extension MessageFilterExtension: ILMessageFilterQueryHandling {
    func handle(_ queryRequest: ILMessageFilterQueryRequest, 
                context: ILMessageFilterExtensionContext, 
                completion: @escaping (ILMessageFilterQueryResponse) -> Void) {
        
        // Reuse the SDK instance
        safeConnectionSDK.smsFiltering.handle(queryRequest, context: context, completion: completion)
    }
}

extension MessageFilterExtension: ILMessageFilterCapabilitiesQueryHandling {
    func handle(_ capabilitiesQueryRequest: ILMessageFilterCapabilitiesQueryRequest,
                context: ILMessageFilterExtensionContext,
                completion: @escaping (ILMessageFilterCapabilitiesQueryResponse) -> Void) {
        
        // Reuse the SDK instance
        safeConnectionSDK.smsFiltering.handle(capabilitiesQueryRequest, context: context, completion: completion)
    }
}
```

#### Filter Result Types

The SDK returns standard iOS `ILMessageFilterAction` values:

| Action | Description |
|--------|-------------|
| `.allow` | Allow the message |
| `.junk` | Mark as junk message |
| `.promotion` | Mark as promotional message |
| `.transaction` | Mark as transactional message |
| `.none` | Cannot determine, let the system handle |

---

### Safari URL Scanner

Scan URLs visited in Safari, detect malicious websites, and send warning notifications.

#### API

| Method | Description |
|--------|-------------|
| `safariURLScanner.checkConfidenceLevel(urlString:) async throws -> ConfidenceLevel` | Check URL safety level |
| `safariURLScanner.beginRequest(with:)` | Handle Safari Extension requests |
| `safariURLScanner.showSafariURLScanActivatedNotification()` | Show activation notification |

#### Check URL Safety Level

```swift
let sdk = SafeConnectionSDK()

Task {
    do {
        let level = try await sdk.safariURLScanner.checkConfidenceLevel(urlString: "https://example.com")
        
        switch level {
        case .safe:
            print("Safe website")
        case .suspicious:
            print("Suspicious website, proceed with caution")
        case .malicious:
            print("Malicious website, do not visit")
        case .unknown:
            print("Cannot determine")
        default:
            print("Other: \(level.rawValue)")
        }
        
        if level.isDangerous {
            print("Warning: This website may be risky!")
        }
    } catch {
        print("Scan failed: \(error)")
    }
}
```

#### Handle Requests in Safari Web Extension

Create a Safari Web Extension target and implement:

```swift
import SafariServices
import SafeConnection

class SafariWebExtensionHandler: NSObject, NSExtensionRequestHandling {
    
    // Store SDK instance to reuse across requests
    let safeConnectionSDK: SafeConnectionSDK
    
    // IMPORTANT: SDK must be initialized in init()
    override init() {
        do {
            try SafeConnectionSDK.configure()
        } catch {
            print("SDK initialization failed: \(error)")
        }
        self.safeConnectionSDK = SafeConnectionSDK()
        super.init()
    }
    
    func beginRequest(with context: NSExtensionContext) {
        // Reuse the SDK instance
        safeConnectionSDK.safariURLScanner.beginRequest(with: context)
    }
}
```

#### Safari Web Extension Setup Guide

The Safari Web Extension requires both Swift code and web resources (HTML, CSS, JavaScript). This guide provides a complete, ready-to-use implementation.

##### Step 1: Create Safari Web Extension Target

1. In Xcode, select **File > New > Target**
2. Choose **Safari Extension** (not Safari App Extension)
3. Name it (e.g., `SafariURLScan`)
4. Make sure "Safari Web Extension" type is selected

##### Step 2: Create the Resources Folder Structure

Create the following folder structure in your Safari Extension target:

```
Resources/
├── _locales/
│   └── en/
│       └── messages.json
├── images/
│   ├── icon-48.png
│   ├── icon-64.png
│   ├── icon-96.png
│   ├── icon-128.png
│   ├── icon-256.png
│   ├── icon-512.png
│   └── toolbar-icon.svg
├── manifest.json
├── background.js
├── content.js
├── popup.html
├── popup.css
└── popup.js
```

##### Step 3: Copy the Following Files

**`manifest.json`** - Extension manifest (manifest v3)

```json
{
    "manifest_version": 3,
    "default_locale": "en",

    "name": "__MSG_extension_name__",
    "description": "__MSG_extension_description__",
    "version": "1.0",

    "icons": {
        "48": "images/icon-48.png",
        "96": "images/icon-96.png",
        "128": "images/icon-128.png",
        "256": "images/icon-256.png",
        "512": "images/icon-512.png"
    },

    "background": {
        "scripts": [ "background.js" ],
        "persistent": false
    },

    "content_scripts": [{
        "js": [ "content.js" ],
        "matches": [ "<all_urls>" ]
    }],

    "action": {
        "default_popup": "popup.html",
        "default_icon": "images/toolbar-icon.svg"
    },

    "permissions": [ "activeTab", "nativeMessaging", "tabs"]
}
```

**`background.js`** - Background script for native messaging

```javascript
browser.runtime.onMessage.addListener((request, sender, sendResponse) => {
    if (request.action === "urlScan")
        scan(request.url, request.title);
});

function scan(url, title) {
    browser.runtime.sendNativeMessage({ action: "urlScan", url: url, title: title }, function(response) {
        console.log("Received response:", response);
        sendResponse(response);
    });
}
```

**`content.js`** - Content script injected into web pages (auto-scans every page)

```javascript
checkURLInBackground()

function checkURLInBackground() {
    let url = window.location.href
    let title = document.title
    browser.runtime.sendMessage({ action: "urlScan", url: url, title: title });
}

browser.runtime.onMessage.addListener(function(message, sender, sendResponse) {
    if (message.action === "goToSafeConnectionMainApp") {
        let url = message['scheme'] + "://"
        location.href = url;
    }
});
```

**`popup.html`** - Toolbar popup UI

```html
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Popup</title>
        <link rel="stylesheet" href="popup.css">
    </head>
    <body>
        <div class="container">
            <img src="images/icon-128.png" alt="Icon" class="icon">
            <div class="title" id="title"></div>
            <div class="content" id="content"></div>
            <button class="action-button" id="actionButton"></button>
        </div>
        <script src="popup.js"></script>
    </body>
</html>
```

**`popup.css`** - Popup styles

```css
body {
    margin: 0;
    font-family: -apple-system, BlinkMacSystemFont, sans-serif;
    min-width: 280px;
}

.container {
    text-align: center;
    padding: 40px 20px;
}

.icon {
    width: 48px;
    height: 48px;
}

.title {
    color: rgba(33, 33, 33, 0.9);
    font-size: 15px;
    font-weight: 600;
    padding-top: 20px;
}

.content {
    color: rgba(33, 33, 33, 0.7);
    font-size: 13px;
    padding-top: 8px;
    line-height: 1.4;
}

.action-button {
    background-color: #00C300;
    color: #FFFFFF;
    font-size: 13px;
    font-weight: 600;
    padding: 8px 24px;
    margin-top: 20px;
    border: none;
    cursor: pointer;
    border-radius: 16px;
}

.action-button:hover {
    background-color: #00A000;
}
```

**`popup.js`** - Popup logic

```javascript
document.addEventListener('DOMContentLoaded', function () {
    const titleText = browser.i18n.getMessage("popupTitle");
    const contentText = browser.i18n.getMessage("popupContent");
    const buttonText = browser.i18n.getMessage("popupButtonTitle");

    document.getElementById('title').textContent = titleText;
    document.getElementById('content').textContent = contentText;
    
    const actionButton = document.getElementById('actionButton');
    actionButton.textContent = buttonText;

    actionButton.addEventListener('click', function() {
        window.close();
        browser.tabs.query({active: true, currentWindow: true}, function(tabs) {
            // ⚠️ IMPORTANT: Change "your-app-scheme" to your app's URL scheme
            browser.tabs.sendMessage(tabs[0].id, { 
                "action": "goToSafeConnectionMainApp", 
                "scheme": "your-app-scheme" 
            });
        });
    });
});
```

**`_locales/en/messages.json`** - Localization strings

```json
{
    "extension_name": {
        "message": "Your App Safari URL Scanner"
    },
    "extension_description": {
        "message": "Automatically check websites and notify when risks are found."
    },
    "popupTitle": {
        "message": "Auto Web Checker is enabled"
    },
    "popupContent": {
        "message": "When a suspicious website is found, you will be alerted via notification."
    },
    "popupButtonTitle": {
        "message": "Back to App"
    }
}
```

##### Step 4: Add Your App Icons

Add the following icon files to the `Resources/images/` folder:

| File | Size | Purpose |
|------|------|---------|
| `icon-48.png` | 48x48 | Extension icon |
| `icon-64.png` | 64x64 | Extension icon |
| `icon-96.png` | 96x96 | Extension icon |
| `icon-128.png` | 128x128 | Extension icon / Popup icon |
| `icon-256.png` | 256x256 | Extension icon |
| `icon-512.png` | 512x512 | Extension icon |
| `toolbar-icon.svg` | Vector | Safari toolbar button |

##### Step 5: Required Customizations

Before building, make sure to update these values:

| File | What to Change | Example |
|------|----------------|---------|
| `popup.js` | URL scheme (line with `"scheme":`) | `"scheme": "myapp"` |
| `messages.json` | `extension_name` | `"Your App Safari URL Scanner"` |
| `messages.json` | `extension_description` | Your app description |
| `messages.json` | `popupButtonTitle` | `"Back to Your App"` |

##### How It Works

```
┌─────────────────────────────────────────────────────────────────────────┐
│                           Safari Browser                                 │
├─────────────────────────────────────────────────────────────────────────┤
│  1. User visits a webpage                                                │
│           │                                                              │
│           ▼                                                              │
│  ┌─────────────────┐                                                     │
│  │   content.js    │  Injected into every page                           │
│  │                 │  Extracts URL and page title                        │
│  └────────┬────────┘                                                     │
│           │ sendMessage({ action: "urlScan", url, title })               │
│           ▼                                                              │
│  ┌─────────────────┐                                                     │
│  │  background.js  │  Receives message from content script               │
│  │                 │  Forwards to native app                             │
│  └────────┬────────┘                                                     │
│           │ sendNativeMessage({ action: "urlScan", url, title })         │
└───────────┼─────────────────────────────────────────────────────────────┘
            │
            ▼
┌─────────────────────────────────────────────────────────────────────────┐
│                      Safari Web Extension (Native)                       │
├─────────────────────────────────────────────────────────────────────────┤
│  ┌──────────────────────────┐                                            │
│  │ SafariWebExtensionHandler│  Receives native message                   │
│  │                          │  Calls SDK to scan URL                     │
│  └────────────┬─────────────┘                                            │
│               │ safariURLScanner.beginRequest(with: context)             │
│               ▼                                                          │
│  ┌──────────────────────────┐                                            │
│  │   SafeConnectionSDK      │  Checks URL against security database      │
│  │                          │  Returns: safe/suspicious/malicious        │
│  └────────────┬─────────────┘                                            │
│               │                                                          │
│               ▼                                                          │
│  ┌──────────────────────────┐                                            │
│  │  Local Notification      │  If dangerous URL detected:                │
│  │  (Automatic)             │  "⚠️ Beware: [URL]"                        │
│  └──────────────────────────┘                                            │
└─────────────────────────────────────────────────────────────────────────┘
```

##### Troubleshooting

| Issue | Solution |
|-------|----------|
| Extension not appearing in Safari | Go to Safari > Settings > Extensions and enable your extension |
| "Back to App" button not working | Make sure the URL scheme is registered in your main app's `Info.plist` |
| No notifications appearing | Check notification permissions in iOS Settings > Your App > Notifications |
| Extension crashes on load | Verify `SafeConnectionSDK.configure()` is called in `SafariWebExtensionHandler.init()` |

#### ConfidenceLevel

| Level | rawValue | Description | isDangerous |
|-------|----------|-------------|-------------|
| `.safe` | `"safe"` | Safe website | `false` |
| `.suspicious` | `"suspicious"` | Suspicious website | `true` |
| `.malicious` | `"malicious"` | Malicious website | `true` |
| `.unknown` | `"unknown"` | Cannot determine | `false` |

---

## Data Structures

### NumberInfo

Data structure for number search results.

```swift
public struct NumberInfo {
    public let e164: String              // Phone number
    public var name: String = ""         // Name (default: empty string)
    public var businessCategory: String = ""  // Business category (default: empty string)
    public var spamCategory: String = "" // Spam category (default: empty string)
    public var spam: String = ""         // Spam label (default: empty string)
    public var spamLevel: Int = 0        // Spam level (default: 0)
}
```

#### Field Descriptions

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `e164` | String | - | Phone number. Supports 3 formats: `0912345678`, `886912345678`, or `+886912345678` |
| `name` | String | `""` | Number name (company name, personal name, etc.) |
| `businessCategory` | String | `""` | Business category (e.g., restaurant, bank, etc.) <!-- TODO: Add all possible values --> |
| `spamCategory` | String | `""` | Spam classification <!-- TODO: Add all possible values and definitions --> |
| `spam` | String | `""` | Spam label description |
| `spamLevel` | Int | `0` | Spam level <!-- TODO: Add value range and definitions --> |

### ConfidenceLevel

Confidence level for URL safety check results.

```swift
public struct ConfidenceLevel: RawRepresentable, Hashable {
    public let rawValue: String
    
    public static let safe = Self(rawValue: "safe")
    public static let suspicious = Self(rawValue: "suspicious")
    public static let unknown = Self(rawValue: "unknown")
    public static let malicious = Self(rawValue: "malicious")
    
    public var isDangerous: Bool  // true when suspicious or malicious
}
```

---

## Error Handling

### General Error Handling Pattern

Since the SDK's internal error types are not publicly exposed, use the standard Swift error handling pattern with `localizedDescription`:

```swift
do {
    let result = try await sdk.search(e164: "+886912345678")
} catch {
    print("Error: \(error)")
}
```

### SafeConnectionSDK.Options.Error

Configuration errors when initializing the SDK:

| Error | Description |
|-------|-------------|
| `missingPlistURL` | Configuration file URL does not exist or is invalid |

```swift
do {
    let options = try SafeConnectionSDK.Options(plistURL: nil)
} catch SafeConnectionSDK.Options.Error.missingPlistURL {
    print("Plist URL is missing")
} catch {
    print("Configuration error: \(error)")
}
```

### PersonalBlockingPersistingError

Errors from personal blocking operations:

| Error | Description |
|-------|-------------|
| `reachedLimit` | Maximum blocking limit reached (500 numbers) |
| `numberAlreadyExists` | Number already exists in blocking list |
| `numberNotFound` | Number not found in blocking list |
| `fileOperationFailed(underlying:)` | File operation failed |

```swift
let result = await sdk.blockNumber(number: "+886912345678")
switch result {
case .success:
    print("Success")
case .failure(let error as PersonalBlockingPersistingError):
    switch error {
    case .reachedLimit:
        print("Maximum 500 numbers reached")
    case .numberAlreadyExists:
        print("Number already blocked")
    case .numberNotFound:
        print("Number not in list")
    case .fileOperationFailed(let underlying):
        print("File error: \(underlying)")
    }
case .failure(let error):
    print("Other error: \(error)")
}
```

### Common Error Scenarios

| Operation | Possible Error | Description |
|-----------|----------------|-------------|
| SDK Initialization | `missingPlistURL` | Plist file not found |
| Number Search | HTTP 403 | Authentication failed or token expired |
| Offline Database | Network error | Failed to download database |
| Personal Blocking | `reachedLimit` | Exceeded 500 number limit |
| URL Scanner | Network error | Failed to connect to server |

---

## Usage Limits

### Number Search

| Item | Limit |
|------|-------|
| Number Format | E.164 format recommended (e.g., `+886912345678`) |
| Authentication | Valid License ID required |
<!-- | API Rate Limit | TODO: Add Rate Limit -->

### Personal Blocking

| Item | Limit |
|------|-------|
| Maximum Blocked Numbers | 500 |
| Number Format | Supports E.164 format or numeric format |

### SMS Filtering

| Item | Limit |
|------|-------|
| Rule Update Frequency | Automatically updates every 7 days |
| Offline Support | Supported (uses downloaded rules) |

### Safari URL Scanner

| Item | Limit |
|------|-------|
| Result Cache | Same URL scan results cached for 1 day |
| Network Requirement | Network connection required for first scan |

---

## Support

For any questions or assistance, please contact the Gogolook technical support team.

---

## Version History

| Version | Date | Description |
|---------|------|-------------|
| 0.5.26 | - | Current version |
