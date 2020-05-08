![Swift CI](https://github.com/mackoj/PlatformLookup/workflows/Swift%20CI/badge.svg?event=push)

# Bitrise Support

Being able to lift platform information in bitrise in order to simplify maintenance.

- PLATFORM_LOOKUP_DEVICE_MODEL : Device model like `iPad Air (3rd generation)`
- PLATFORM_LOOKUP_OS_VERSION : Runtime os version `13.3`
- PLATFORM_LOOKUP_DEVICE_UDID : Simulator device UDID `97FF12DC-7204-4066-A95E-A2B0E6FF4F62`
- PLATFORM_LOOKUP_PLATFORM : Platform parameter for xcodebuild `iOS Simulator,name=iPad Air (3rd generation),OS=13.3`
- PLATFORM_LOOKUP_SIMULATOR_NAME : Simulator name `iOS Simulator`

```shell
git clone https://github.com/mackoj/PlatformLookup.git
cd PlatformLookup
swift run cli iPhone --share-to-envman
```

# Cli 📟

You can use the cli to find the platform you need by passing the device name or juste the device family you can optionnaly set the os version you are looking for.

```shell
swift run cli iphone
iOS Simulator,name=iPhone 11 Pro Max,OS=13.3
```

```shell
swift run cli "iPad Air (3rd generation)"
iOS Simulator,name=iPad Air (3rd generation),OS=13.3
```

```shell
swift run cli watch
watchOS Simulator,name=Apple Watch Series 5 - 44mm,OS=6.1.1
```

```shell
swift run cli tv -v 13.3
tvOS Simulator,name=Apple TV 4K (at 1080p),OS=13.3
```

```shell
swift run cli --all-platform all
iOS Simulator,name=iPhone SE (2nd generation),OS=13.4.1
iOS Simulator,name=iPad Air (3rd generation),OS=13.4.1
tvOS Simulator,name=Apple TV 4K (at 1080p),OS=13.4
watchOS Simulator,name=Apple Watch Series 5 - 44mm,OS=6.2
```

`--help`
```
USAGE: platform-lookup-cli <name> [--runtime-version <runtime-version>] [--show-all] [--share-to-envman] [--version] [--print-with-platform]

ARGUMENTS:
  <name>                  Platform you are looking for. (ex. iPhone)

OPTIONS:
  -r, --runtime-version <runtime-version>
                          Runtime version you are targeting. (ex. 13.2)
  --show-all              Show all available options.
  --share-to-envman       Share info to Bitrise envman.
  --version               Print tool version.
  --print-with-platform   Print in the other form.(ex: platform="iOS Simulator,name=iPhone 11 Pro Max,OS=13.4")
  -h, --help              Show help information.
```
# PlatformLookup 🔎

This package help to find/filter/sort all devices and runtimes available in xcrun simctl.

```swift
#!/usr/bin/swift sh

import Foundation
import PlatformLookup  // @mackoj

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
