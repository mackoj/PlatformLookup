import CommandParser
import Foundation
import PlatformLookup

let Version = "1.0.0"
let Usage = """
    SUBCOMMAND [OPTIONS]...
    EXAMPLES:
      Check every Swift source under ./Sources for problems:
        drstring check -i "Sources/**/*.swift"
      Explain the problem associated with ID `E007`:
        drstring explain E007
      Automatically fix formatting issues according to a config file:
        drstring format --config-file path/to/.drstring.toml
  """

func performCommand(_ command: PlatformLookupCommand) throws {
  if command.version {
    fputs(Version, stdout)
    exit(EXIT_SUCCESS)
  }
  let platforms = try PlatformLookup.findAllDeviceNamed(
    command.name,
    version: command.runtimeVersion
  )
  let platform = platforms.last!
  let deviceFamily = try PlatformLookup.deviceFamilyFrom(command.name)
  let output = try PlatformLookup.format(platform, deviceFamily: deviceFamily)
  fputs(output + "\n", stdout)
  if command.showAll { fputs(platform.description, stdout) }
}

func exe(_ args: [String]) throws {
  let command = PlatformLookupCommand.parseOrExit(args)
  try performCommand(command)
}

do { try exe(CommandLine.arguments) } catch let error as PlatformLookup.PlatformLookupError {
  fputs(error.localizedDescription, stderr)
  exit(EXIT_FAILURE)
} catch {
  fputs(Usage, stderr)
  exit(EXIT_FAILURE)
}
exit(EXIT_SUCCESS)
