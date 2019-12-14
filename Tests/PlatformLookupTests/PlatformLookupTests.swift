import SimulatorControl
import XCTest

@testable import PlatformLookup

final class PlatformLookupTests: XCTestCase {
  override func setUp() { try? PlatformLookup.instanciate(SimulatorControlJSONData) }
  func test_decodeXcrunSimctlJSONData() {
    do {
      let simctl = try JSONDecoder().decode(SimulatorControl.self, from: SimulatorControlJSONData)
      let runtimesSorted = simctl.runtimes?.sorted(by: >)
      if let firstRuntime = runtimesSorted?.first {
        let testRuntime = Runtime(
          version: "13.2",
          bundlePath:
            "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Library/Developer/CoreSimulator/Profiles/Runtimes/iOS.simruntime",
          isAvailable: true,
          name: "iOS 13.2",
          identifier: "com.apple.CoreSimulator.SimRuntime.iOS-13-2",
          buildversion: "17B84"
        )
        XCTAssertEqual(firstRuntime, testRuntime)
        let identifier = firstRuntime.identifier
        let devices = simctl.devices?[identifier]!
        let iPhones = devices?.filter({ (device) -> Bool in
          let isIphone = device.name.contains("iPhone")
          let isAvailable = device.isAvailable ?? false
          return (isIphone && isAvailable)
        })
        let testDevice = Device(
          state: "Shutdown",
          isAvailable: true,
          name: "iPhone 8",
          udid: "B105B3E9-8316-45C1-8B48-95287FA96397",
          availabilityError: nil
        )
        let finalDevice = iPhones!.first!
        XCTAssertEqual(finalDevice, testDevice)
      }
    } catch { print(error) }
  }
  func test_findADeviceForLastOSVersion_string() {
    let platform: String? = try? PlatformLookup.findADeviceForLastOSVersion()
    XCTAssertEqual(platform, "platform=\"iOS Simulator,name=iPhone 11 Pro Max,OS=13.2\"")
  }
  func test_findADeviceForLastOSVersion_platform() {
    let platform: Platform? = try? PlatformLookup.findADeviceForLastOSVersion()
    let device = Device(
      state: "Shutdown",
      isAvailable: true,
      name: "iPhone 11 Pro Max",
      udid: "B0184528-5026-4FAC-9EBC-67597183CF84",
      availabilityError: nil
    )
    let runtime = Runtime(
      version: "13.2",
      bundlePath:
        "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Library/Developer/CoreSimulator/Profiles/Runtimes/iOS.simruntime",
      isAvailable: true,
      name: "iOS 13.2",
      identifier: "com.apple.CoreSimulator.SimRuntime.iOS-13-2",
      buildversion: "17B84"
    )
    XCTAssertEqual(platform?.runtime, runtime)
    XCTAssertEqual(platform?.devices.last, device)
  }
  func test_findADeviceForLastOSVersion_allCases() {
    var device = Device(
      state: "Shutdown",
      isAvailable: true,
      name: "iPhone 11 Pro Max",
      udid: "B0184528-5026-4FAC-9EBC-67597183CF84",
      availabilityError: nil
    )
    var runtime = Runtime(
      version: "13.2",
      bundlePath:
        "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Library/Developer/CoreSimulator/Profiles/Runtimes/iOS.simruntime",
      isAvailable: true,
      name: "iOS 13.2",
      identifier: "com.apple.CoreSimulator.SimRuntime.iOS-13-2",
      buildversion: "17B84"
    )
    let p1 = Platform(runtime: runtime, device: device)

    device = Device(
      state: "Shutdown",
      isAvailable: true,
      name: "iPad Air (3rd generation)",
      udid: "7AD860C2-D789-4564-B515-93425EDD0EDB",
      availabilityError: nil
    )
    runtime = Runtime(
      version: "13.2",
      bundlePath:
        "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Library/Developer/CoreSimulator/Profiles/Runtimes/iOS.simruntime",
      isAvailable: true,
      name: "iOS 13.2",
      identifier: "com.apple.CoreSimulator.SimRuntime.iOS-13-2",
      buildversion: "17B84"
    )
    let p2 = Platform(runtime: runtime, device: device)
    device = Device(
      state: "Shutdown",
      isAvailable: true,
      name: "Apple TV 4K (at 1080p)",
      udid: "76998A1E-F5F5-4F63-B86C-805C25C7C5DB",
      availabilityError: nil
    )
    runtime = Runtime(
      version: "13.2",
      bundlePath:
        "/Applications/Xcode.app/Contents/Developer/Platforms/AppleTVOS.platform/Library/Developer/CoreSimulator/Profiles/Runtimes/tvOS.simruntime",
      isAvailable: true,
      name: "tvOS 13.2",
      identifier: "com.apple.CoreSimulator.SimRuntime.tvOS-13-2",
      buildversion: "17K81"
    )
    let p3 = Platform(runtime: runtime, device: device)

    device = Device(
      state: "Shutdown",
      isAvailable: true,
      name: "Apple Watch Series 5 - 44mm",
      udid: "C69C4207-D98A-4372-BB4D-F08708C50921",
      availabilityError: nil
    )
    runtime = Runtime(
      version: "6.1",
      bundlePath:
        "/Applications/Xcode.app/Contents/Developer/Platforms/WatchOS.platform/Library/Developer/CoreSimulator/Profiles/Runtimes/watchOS.simruntime",
      isAvailable: true,
      name: "watchOS 6.1",
      identifier: "com.apple.CoreSimulator.SimRuntime.watchOS-6-1",
      buildversion: "17S83"
    )
    let p4 = Platform(runtime: runtime, device: device)

    for (expectedPlatform, aCase) in zip([p1, p2, p3, p4], PlatformLookup.DeviceFamily.allCases) {
      let platform: Platform? = try? PlatformLookup.findADeviceForLastOSVersion(aCase)
      XCTAssertEqual(platform?.runtime, expectedPlatform.runtime)
      XCTAssertEqual(platform?.devices.last, expectedPlatform.devices.last)
    }
  }
  static var allTests = [
    ("test_decodeXcrunSimctlJSONData", test_decodeXcrunSimctlJSONData),
    ("test_findADeviceForLastOSVersion_string", test_findADeviceForLastOSVersion_string),
    ("test_findADeviceForLastOSVersion_platform", test_findADeviceForLastOSVersion_platform),
    ("test_findADeviceForLastOSVersion_allCases", test_findADeviceForLastOSVersion_allCases),
  ]
}
