import Foundation
import PlatformLookup

extension String: Error {}

let cliVersion = "1.0.0"

func exe(_ args: [String]) throws {
  var arguments = args
  var version: String?
  var name: String!
  while arguments.isEmpty == false {
    let arg = arguments.removeFirst()
    switch arg {
    case "--version": print("\(cliVersion)")
    case "--help":
      let usage = "./plCli iPhone -v 13.0 -l"
      print(usage)
    case "-v": version = arguments.removeFirst()
    default: name = arg
    }
  }
  let platform = try PlatformLookup.findAllDeviceNamed(name, version: version)
  let deviceFamily = try PlatformLookup.deviceFamilyFrom(name)
  let output = try PlatformLookup.format(
    platform.last!,
    deviceFamily: deviceFamily
  )
  print(output)
  print(platform.last!.devices.last!)
}

do {
  try exe(Array(CommandLine.arguments.dropFirst()))
  exit(EXIT_SUCCESS)
}
catch {
  print(error.localizedDescription)
  exit(EXIT_FAILURE)
}
