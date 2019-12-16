import Foundation
import PlatformLookup  // mackoj/SimulatorControl
import TSCUtility

func parseArgument(_ args: [String]) throws {
  let parser = ArgumentParser(commandName:"plCLI", usage: "xcrun simctl platform lookup helper", overview: "Sample overview")
  let osVersion = parser.add(option: "--os-version", shortName: "-v", kind: String.self, strategy: .upToNextOption, usage: "Version of the OS(13.2/6.1)", completion: nil /* <#T##ShellCompletion?#> */)
  let name = parser.add(option: "--name", shortName: "-n", kind: String.self, strategy: .upToNextOption, usage: "Full name of the device(Apple Watch Series 4 - 44mm) or partial name(iPhone/iPad/watch/tv)", completion: nil /* <#T##ShellCompletion?#> */)
  let lov = parser.add(option: "--last-os-version", shortName: "-l", usage: "Get only the last device on the last os version", completion: nil /* <#T##ShellCompletion?#> */)
  let pl = parser.add(option: "--formatted-platform", shortName: "-f", usage: "Get only the formated platformed(iOS Simulator,name=iPhone 11 Pro Max,OS=13.2)", completion: nil /* <#T##ShellCompletion?#> */)
  let usage = parser.add(option: "--usage", usage: "How to use the cli")
  let version = parser.add(option: "--version", usage: "what is the version of the cli")

  let res = try parser.parse(args)

  if let df = res.get(name) {
    let platforms = PlatformLookup.findAllDeviceNamed(df, version: res.get(osVersion))
    if let _ = res.get(lov) {
      return platforms.last
    }
    return platforms
  }


func findDevicePlatform(_ args: [String]) throws {
  if let platform:String = try PlatformLookup.findADeviceForLastOSVersion() {
    // Expecting: iOS Simulator,name=iPhone 11 Pro Max,OS=13.2
    print(platform)
  } else {
    print("👉 Failure 💩")
    exit(EXIT_FAILURE)
  }
}

do { try findDevicePlatform(CommandLine.arguments) } catch {
  print(error.localizedDescription)
  exit(EXIT_FAILURE)
}
