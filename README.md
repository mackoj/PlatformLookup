# PlatformLookup 🔎

This package help to find/filter/sort all devices and runtimes available in xcrun simctl.

```swift
#!/usr/bin/swift sh

import Foundation
import PlatformLookup  // @mackoj

func findDevicePlatform(_ args: [String]) throws {
  if let platform: String = try PlatformLookup.findADeviceForLastOSVersion() {
    // Expecting: iOS Simulator,name=iPhone 11 Pro Max,OS=13.2
    print(platform)
  } else {
    print("👉 Failure 💩")
    exit(EXIT_FAILURE)
  }
}

do {
  try findDevicePlatform(CommandLine.arguments)
} catch {
  print(error.localizedDescription)
  exit(EXIT_FAILURE)
}
```

# SimulatorControl 📲

This package is a representation of xcrun simctl devices and runtimes it act as a model here.

```swift
```

# Shell 🐚

A Simple help to perform shell command

```swift
```
