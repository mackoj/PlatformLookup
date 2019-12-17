#!/usr/bin/swift sh

import Foundation
import PlatformLookup  // mackoj/SimulatorControl
import Shell

func findDevicePlatform(_ args: [String]) throws {
  let platform = try PlatformLookup.findADeviceForLastOSVersion(.iPhone)
  _ = try shell(
    "envman add --key PLATFORM_LOOKUP_DEVICE_MODEL --value \"\(platform.devices.last!.name)\""
  )
  _ = try shell(
    "envman add --key PLATFORM_LOOKUP_OS_VERSION --value \"\(platform.runtime.version)\""
  )
  let platformString = try PlatformLookup.format(
    platform,
    deviceFamily: .iPhone
  )
  _ = try shell(
    "envman add --key PLATFORM_LOOKUP_PLATFORM --value \"\(platformString)\""
  )
  print(platformString)
  exit(EXIT_SUCCESS)
}

do { try findDevicePlatform(CommandLine.arguments) }
catch {
  print(error.localizedDescription)
  exit(EXIT_FAILURE)
}
