import ArgumentParser
import Foundation
import PlatformLookup
import Shell

struct PlatformLookupCLI: ParsableCommand {
  static var configuration = CommandConfiguration(
    abstract: "A utility for getting simulator list.",
    version: "1.0.0"
  )
  @Argument(help:"Platform you are looking for. (ex. iPhone or \"iPad Air (3rd generation)\")") public var name: String
  @Option(name:.shortAndLong,help:"Runtime version you are targeting. (ex. 13.2)") public
    var runtimeVersion: String?
  @Flag(help:"Show all devices for a runtime") public var showAll: Bool

  @Flag(help:"Show all platforms. (ex: swift run cli --all-platform all)") public var allPlatform:
    Bool

  @Flag(help:"Share info to Bitrise envman.") public var shareToEnvman: Bool

  @Flag(help:"Print in the other form.(ex: platform=\"iOS Simulator,name=iPhone 11 Pro Max,OS=13.4\")")
  public var printWithPlatform: Bool
  func displayPlatformInformation(_ inputName: String) throws {
    let platforms = try PlatformLookup.findAllDeviceNamed(inputName, version: runtimeVersion)
    let platform = platforms.last!
    let deviceFamily = try PlatformLookup.deviceFamilyFrom(inputName)
    let output = try PlatformLookup.format(platform, deviceFamily: deviceFamily)
    if printWithPlatform { fputs("platform=\"" + output + "\"\n", stdout) } else {
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
  func run() throws {
    if shareToEnvman, allPlatform {
      throw
        (PlatformLookup.PlatformLookupError.impossibleConfiguration(
          "shareToEnvman(\(shareToEnvman) and allPlatform(\(allPlatform) because shareToEnvman will get only the last platform"
        ))
    }
    if allPlatform {
      for aDeviceFamily in PlatformLookup.DeviceFamily.allCases {
        try displayPlatformInformation(aDeviceFamily.rawValue)
      }
    } else { try displayPlatformInformation(name) }
  }
}

PlatformLookupCLI.main()
