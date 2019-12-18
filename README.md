# Bitrise Support

Being able to lift platform information in bitrise in order to simplify maintenance.

- PLATFORM_LOOKUP_DEVICE_MODEL : Device model like `iPad Air (3rd generation)`
- PLATFORM_LOOKUP_OS_VERSION : Runtime os version `13.3`
- PLATFORM_LOOKUP_DEVICE_UDID : Simulator device UDID `97FF12DC-7204-4066-A95E-A2B0E6FF4F62`
- PLATFORM_LOOKUP_PLATFORM : Platform parameter for xcodebuild `iOS Simulator,name=iPad Air (3rd generation),OS=13.3`
- PLATFORM_LOOKUP_SIMULATOR_NAME : Simulator name `iOS Simulator`

It can use the same parameter as `Cli`.

```shell
swift sh <(curl https://raw.githubusercontent.com/mackoj/SimulatorControl/master/bitrisePlatformLookup.swift) iPhone
```

# Cli 📟

You can use the cli to find the platform you need by passing the device name or juste the device family you can optionnaly set the os version you are looking for.

```shell
./cli iphone
iOS Simulator,name=iPhone 11 Pro Max,OS=13.3
```

```shell
./cli "iPad Air (3rd generation)"
iOS Simulator,name=iPad Air (3rd generation),OS=13.3
```

```shell
./cli watch
watchOS Simulator,name=Apple Watch Series 5 - 44mm,OS=6.1.1
```

```shell
./cli tv -v 13.3
tvOS Simulator,name=Apple TV 4K (at 1080p),OS=13.3
```

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

# Shell 🐚

A Simple help to perform a shell command and pipe it's output.

```swift
shell("xcrun simctl list -j")
```

# SimulatorControl 📲

This package is a representation of xcrun simctl devices and runtimes it act as a model here.

```shell
xcrun simctl list -j > simctl_device_list.json
```
```swift
let simctl = try JSONDecoder().decode(SimulatorControl.self, from: SimulatorControlJSONData)
```
