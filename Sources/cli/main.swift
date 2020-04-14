import ArgumentParser
import Foundation
import PlatformLookup
import Shell

let Version = "1.0.0"

struct PlatformLookupCLI: ParsableCommand {
  @Argument(help:"Platform you are looking for. (ex. iPhone)") public var name: String
  @Option(name:.shortAndLong,help:"Runtime version you are targeting. (ex. 13.2)") public
    var runtimeVersion: String?
  @Flag(help:"Show all available options.") public var showAll: Bool

  @Flag(help:"Share info to Bitrise envman.") public var shareToEnvman: Bool

  @Flag(help:"Print tool version.") public var version: Bool
  @Flag(help:"Print in the other form.") public var printWithPlatform: Bool
  func run() throws {
    if version {
      fputs(Version, stdout)
      return
    }
    let platforms = try PlatformLookup.findAllDeviceNamed(name, version: runtimeVersion)
    let platform = platforms.last!
    let deviceFamily = try PlatformLookup.deviceFamilyFrom(name)
    let output = try PlatformLookup.format(platform, deviceFamily: deviceFamily)
    if printWithPlatform {
      fputs("platform=\"" + output + "\"\n", stdout)
    } else {
      fputs(output + "\n", stdout)
    }
    if showAll { fputs(platform.description, stdout) }
    if shareToEnvman {
      _ = try shell(
        "envman add --key PLATFORM_LOOKUP_DEVICE_MODEL --value \"\(platform.devices.last!.name)\" 2> /dev/null"
      )
      _ = try shell(
        "envman add --key PLATFORM_LOOKUP_OS_VERSION --value \"\(platform.runtime.version)\" 2> /dev/null"
      )
      _ = try shell(
        "envman add --key PLATFORM_LOOKUP_DEVICE_UDID --value \"\(platform.devices.last!.udid)\" 2> /dev/null"
      )
      _ = try shell("envman add --key PLATFORM_LOOKUP_PLATFORM --value \"\(output)\" 2> /dev/null")
      _ = try shell(
        "envman add --key PLATFORM_LOOKUP_SIMULATOR_NAME --value \"\(deviceFamily.simulatorName)\" 2> /dev/null"
      )
    }

  }
}

PlatformLookupCLI.main()
