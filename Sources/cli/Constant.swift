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

let Overview = """
DrString \(Version)

A Swift docstring linter, formatter, nitpicky assistant...

DrString helps you locate and fix docstring problems such as missing
documentation or whitespace errors. It help your team to write consistent
docstrings.

Learn more at: https://github.com/dduan/DrString
"""

extension String: Error {} // this should be replaced
