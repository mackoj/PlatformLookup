import TSCUtility

private let mainOverview = """
  PlatformLookup \(version)
  A Swift docstring linter, formatter, nitpicky assistant...
  DrString helps you locate and fix docstring problems such as missing
  documentation or whitespace errors. It help your team to write consistent
  docstrings.
  Learn more at: https://github.com/dduan/DrString
  """

private let mainUsage = """
  SUBCOMMAND [OPTIONS]...
  EXAMPLES:
    Check every Swift source under ./Sources for problems:
      drstring check -i "Sources/**/*.swift"
    Explain the problem associated with ID `E007`:
      drstring explain E007
    Automatically fix formatting issues according to a config file:
      drstring format --config-file path/to/.drstring.toml
  """

private let nameOverview = """
  Check (lint) source files for docstring problems in given paths.
  """

private let nameUsage = """
  [OPTIONS]...
  Paths are specfied using the `-i/--include` option, they can be repeated.
  Globstar is supported (see example).
  Flags can be used to specify preferred styles for docstrings.
  A configuration file can be used instead of command line options to specify
  preferred styles. The options are equivalent in both methods.
  EXAMPLES:
    Examine all Swift files under `./Sources` recursively:
      drstring check -i 'Sources/**/*.swift'
    Use full name for `-i` (include), exclude some paths from being checked,
    ignore throws, require first letter of keywords (e.g. `throws`, `returns`,
    etc) to be uppercase:
      drstring check \\
          --include 'Sources/**/*.swift' \\
          --include 'Tests/**/*.swift' \\
          --exclude 'Tests/Fixtures/*.swift' \\
          --ignore-throws true \\
          --first-letter uppercase
  """

private let osVersionOverview = """
  Fix docstring formatting errors for sources in given paths.
  """

private let osVersionUsage = """
  [OPTIONS]...
  Paths are specfied using the `-i/--include` option, they can be repeated.
  Globstar is supported (see example).
  Flags can be used to specify preferred styles for docstrings.
  A configuration file can be used instead of command line options to specify
  preferred styles. The options are equivalent in both methods.
  EXAMPLES:
    Fix all Swift files under `./Sources` recursively:
      drstring format -i 'Sources/**/*.swift'
    Use full name for `-i` (include), exclude some paths from being checked,
    ignore throws, require an empty docstring line after parameters, and
    continuation of descriptions to vertical align after ':'s.
      drstring format \\
          --include 'Sources/**/*.swift' \\
          --include 'Tests/**/*.swift' \\
          --exclude 'Tests/Fixtures/*.swift' \\
          --needs-separation parameters \\
          --align-after-colon parameters
  """

let versionOverview = "Print version."
let helpOverview = "Print help."

let (kArgParser, kArgBinder): (ArgumentParser, ArgumentBinder<Command>) = {
  let binder = ArgumentBinder<Command>()
  let main = ArgumentParser(usage: mainUsage, overview: mainOverview)
  let name = main.add(
    subparser: "name",
    usage: nameUsage,
    overview: nameOverview
  )
  let osVersion = main.add(
    subparser: "osVersion",
    usage: osVersionUsage,
    overview: osVersionOverview
  )
  _ = main.add(subparser: "version", usage: "", overview: versionOverview)
  _ = main.add(subparser: "help", usage: "", overview: helpOverview)
  binder.bind(parser: main) { (commandOption, sub) in//    switch subcommand {
    //    case "name":
    //      name = .name("toto")
    //    case "osVersion":
    //      osVersion = .format(Configuration())
    //    case "version":
    //      command = .version
    //    default:
    //      command = .help
    //    }
  }
  for parser in [name, osVersion] {
    binder.bind(
      option: parser.add(
        option: "--name",
        shortName: "-n",
        kind: String.self,
        usage: "Parser Usage..... blablabla"
      )
    ) { (cmd, pourris) in print(cmd)
      print(pourris)
    }
  }
  return (main, binder)
}()
