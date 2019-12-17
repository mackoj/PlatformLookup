# PlatformLookup 🔎

This package help to find/filter/sort all devices and runtimes available in xcrun simctl.

```swift
#!/usr/bin/swift sh

import Foundation
import PlatformLookup  // mackoj/SimulatorControl

func findDevicePlatform(_ args: [String]) throws {
  let platform = try PlatformLookup.findADeviceForLastOSVersion(.iPhone)
  let platformString = try PlatformLookup.format(
    platform,
    deviceFamily: .iPhone
  )
  print(platformString)
  exit(EXIT_SUCCESS)
}

do { try findDevicePlatform(CommandLine.arguments) }
catch {
  print(error.localizedDescription)
  exit(EXIT_FAILURE)
}
```
## Cli

You can use the cli to find the platform you need by passing the device name or juste the device family you can optionnaly set the os version you are looking for.

```shell
$>./cli iphone
iOS Simulator,name=iPhone 11 Pro Max,OS=13.3
```

```shell
$>./cli "iPad Air (3rd generation)"
iOS Simulator,name=iPad Air (3rd generation),OS=13.3
```

```shell
$>./cli watch
watchOS Simulator,name=Apple Watch Series 5 - 44mm,OS=6.1.1
```

```shell
$>./cli tv -v 13.3
tvOS Simulator,name=Apple TV 4K (at 1080p),OS=13.3
```

# SimulatorControl 📲

This package is a representation of xcrun simctl devices and runtimes it act as a model here.

```shell
xcrun simctl list -j > simctl_device_list.json
```
```swift
let simctl = try JSONDecoder().decode(SimulatorControl.self, from: SimulatorControlJSONData)
```

# Shell 🐚

A Simple help to perform a shell command and pipe it's output.

```swift
shell("xcrun simctl list -j")
```
