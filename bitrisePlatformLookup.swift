#!/usr/bin/swift sh

import Foundation
import PlatformLookup // @mackoj
import Shell // @mackoj
import CommandParser // @mackoj

func performCommand(_ command : PlatformLookupCommand) throws {
  let platforms = try PlatformLookup.findAllDeviceNamed(command.name, version: command.runtimeVersion)
  let platform = platforms.last!
  let deviceFamily = try PlatformLookup.deviceFamilyFrom(command.name)
  let output = try PlatformLookup.format(platform, deviceFamily: deviceFamily)

  _ = try shell(
    "envman add --key PLATFORM_LOOKUP_DEVICE_MODEL --value \"\(platform.devices.last!.name)\""
  )
  _ = try shell(
    "envman add --key PLATFORM_LOOKUP_OS_VERSION --value \"\(platform.runtime.version)\""
  )
  _ = try shell(
    "envman add --key PLATFORM_LOOKUP_DEVICE_UDID --value \"\(platform.devices.last!.udid)\""
  )
  _ = try shell(
    "envman add --key PLATFORM_LOOKUP_PLATFORM --value \"\(output)\""
  )
  _ = try shell(
    "envman add --key PLATFORM_LOOKUP_SIMULATOR_NAME --value \"\(deviceFamily.simulatorName)\""
  )
  fputs(output + "\n", stdout)
}

func exe(_ args: [String]) throws {
  let command = PlatformLookupCommand.parseOrExit(args)
  try performCommand(command)
}

do { try exe(Array(CommandLine.arguments.dropFirst())) }
catch let error as PlatformLookup.PlatformLookupError {
  fputs(error.localizedDescription, stderr)
  exit(EXIT_FAILURE)
} catch let error as String {
  fputs(error, stderr)
  exit(EXIT_FAILURE)
} catch {
  exit(EXIT_FAILURE)
}
