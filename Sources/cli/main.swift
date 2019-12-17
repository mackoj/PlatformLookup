import Foundation
import PlatformLookup

let CliVersion = "1.0.0"
let Usage = "./plCli iPhone -v 13.0"

extension String: Error {}

func exe(_ args: [String]) throws {
  var arguments = args
  var version: String?
  var name: String?
  while arguments.isEmpty == false {
    let arg = arguments.removeFirst()
    switch arg {
    case "--version":
      fputs(CliVersion, stdout)
      exit(EXIT_SUCCESS)
    case "--help":
      fputs(Usage, stdout)
      exit(EXIT_SUCCESS)
    case "-v": version = arguments.removeFirst()
    default: name = arg
    }
  }
  guard let localName = name else { throw (Usage) }
  let platform = try PlatformLookup.findAllDeviceNamed(
    localName,
    version: version
  )
  let deviceFamily = try PlatformLookup.deviceFamilyFrom(localName)
  let output = try PlatformLookup.format(
    platform.last!,
    deviceFamily: deviceFamily
  )
  fputs(output, stdout)
}

do { try exe(Array(CommandLine.arguments.dropFirst())) }
catch let error as PlatformLookup.PlatformLookupError {
  fputs(error.localizedDescription, stderr)
  exit(EXIT_FAILURE)
}
catch {
  fputs(Usage, stderr)
  exit(EXIT_FAILURE)
}
exit(EXIT_SUCCESS)
