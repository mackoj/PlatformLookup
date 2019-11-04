import XCTest
@testable import SimulatorControl

final class SimulatorControlTests: XCTestCase {
  func testSerialisation() {
    do {
      let simctl = try JSONDecoder().decode(SimulatorControl.self, from: SimulatorControlJSONData)
      let runtimesSorted = simctl.runtimes?.sorted(by: >)
      if let firstRuntime = runtimesSorted?.first {
        let testRuntime = Runtime(
          version: "13.2",
          bundlePath: "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Library/Developer/CoreSimulator/Profiles/Runtimes/iOS.simruntime",
          isAvailable: true,
          name: "iOS 13.2",
          identifier: "com.apple.CoreSimulator.SimRuntime.iOS-13-2",
          buildversion: "17B84"
        )
        XCTAssert(firstRuntime == testRuntime)
        
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
        XCTAssert(finalDevice == testDevice)
        
      }
    } catch {
      print(error)
    }
  }
  
  func testPlatform() {
    SimulatorControlManager.instanciate(SimulatorControlJSONData)
    let platform = SimulatorControlManager.getPlatform()
    XCTAssert(platform == "platform=iOS Simulator,name=iPhone 11 Pro Max,OS=13.2")
  }
  
  static var allTests = [
    ("testSerialisation", testSerialisation),
    ("testPlatform", testPlatform),
  ]
}
