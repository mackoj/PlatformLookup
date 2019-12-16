import Foundation
import PlatformLookup

private func handle(_ error: CommandOption.CommandError) -> Int32 {
  switch error {
  case .toto: fputs("Config file doesn't exist at.", stderr)
  }
  return EXIT_FAILURE
}

func execute(_ command: CommandOption) throws -> Int32 {
  if (command.help != nil) {
    fputs("USAGE", stdout)
    exit(EXIT_SUCCESS)
  }

  if (command.version != nil) {
    fputs("\(version)", stdout)
    exit(EXIT_SUCCESS)
  }

  guard case .name(let name) = command else {
    fputs("Config file doesn't exist at.", stderr)
    exit(EXIT_FAILURE)
  }
  let platforms = try PlatformLookup.findAllDeviceNamed(
    name,
    version: command.osVersion?.version
  )
  if (command.osVersion?.lastOS != nil), let platform = platforms.last {
    let output = try PlatformLookup.format(platform)
    fputs(output, stdout)
    exit(EXIT_SUCCESS)
  }
  fputs("🤔", stderr)
  exit(EXIT_FAILURE)
}

func run(arguments: [String]) -> Int32 {
  do { return try execute(CommandOption(arguments: arguments)) }
  catch let error {
    fputs("\(error)", stderr)
    return EXIT_FAILURE
  }
}
