import Foundation
// import PlatformLookup  // mackoj/SimulatorControl ~> 0.8.0
import PlatformLookup  // https://github.com/mackoj/SimulatorControl  == a037a15

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
