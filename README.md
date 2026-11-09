# LoggingKit

[![Swift](https://img.shields.io/badge/Swift-6.0+-orange.svg)](https://swift.org)
[![Platforms](https://img.shields.io/badge/Platforms-iOS%20|%20macOS%20|%20tvOS%20|%20watchOS%20|%20visionOS-blue.svg)](https://developer.apple.com)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

A modern, structured, and lightweight logging utility for Swift and SwiftUI with full Swift 6 concurrency support.

---

## Features

- **Structured Log Levels**: `debug`, `info`, `success`, `warning`, and `error`.
- **Visual Formatting**: Color badges and emojis built into every log level for quick terminal and in-app identification.
- **Context Extraction**: Automatically logs file origin, line number, and calling function using `#fileID`, `#function`, and `#line`.
- **Configurable Thresholds**: Control output volume with `AppLogger.minimumLevel`.
- **Custom Log Handlers**: Stream logs to in-app viewers, diagnostics consoles, or external telemetry systems via `AppLogger.logHandler`.
- **Swift 6 & Concurrency Ready**: Built with `Sendable` types and safe concurrency paradigms.

---

## Log Levels

| Level | Emoji | Badge Color | Typical Use |
|---|---|---|---|
| `.debug` | 🔧 | Gray / Secondary | Verbose diagnostics during development |
| `.info` | ℹ️ | Blue | Normal operational events |
| `.success` | ✅ | Green | Successfully completed tasks |
| `.warning` | ⚠️ | Orange | Non-fatal issues or unexpected conditions |
| `.error` | ❌ | Red | Failures and caught exceptions |

---

## Installation

### Swift Package Manager

In Xcode, select **File → Add Package Dependencies...** and enter the repository URL:

```text
https://github.com/GarrettButchko/logging-kit.git
```

Or add it to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/GarrettButchko/logging-kit.git", from: "1.0.0")
]
```

---

## Usage

### Basic Logging

```swift
import LoggingKit

AppLogger.info("Application did launch")
AppLogger.debug("Calculated cache size: \(size)")
AppLogger.success("Downloaded movie assets")
AppLogger.warning("Rate limit approaching: 5 requests remaining")
AppLogger.error("Failed to parse subtitle file")
```

### Logging with Errors

Pass an error directly to include its localized description:

```swift
do {
    try fileManager.removeItem(at: url)
} catch {
    AppLogger.error("Unable to delete cache file", error)
}
```

### Setting Minimum Log Level

Filter out noise in production:

```swift
#if DEBUG
AppLogger.minimumLevel = .debug
#else
AppLogger.minimumLevel = .info
#endif
```

### Custom Log Handler (e.g. for In-App Log Views)

Attach a closure to receive formatted log events:

```swift
AppLogger.logHandler = { level, message in
    DispatchQueue.main.async {
        inAppLogStore.append(LogEntry(level: level, message: message))
    }
}
```

---

## License

`LoggingKit` is available under the [MIT License](LICENSE).
