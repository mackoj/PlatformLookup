import Foundation
import SimulatorControl

extension PlatformLookup {
  
  // MARK: Runtime Filter
  static public func filterRuntime(_ name : String, version : String? = nil) -> ((Runtime) -> Bool) {
    return { runtime in
      let f1 = runtime.name.contains(name)
      guard let version = version else { return f1 }
      return f1 && runtime.version.contains(version)
    }
  }
  
  // MARK: Device Filter
  /// <#Description#>
  /// - Parameter device: <#device description#>
  static public func filterDeviceName(_ deviceName : String) -> ((Device) -> Bool) {
    return { $0.name.contains(deviceName) }
  }

  /// <#Description#>
  /// - Parameter device: <#device description#>
  static public func filterDeviceFamily(_ deviceFamily : DeviceFamily, isAvailable : Bool? = nil) -> ((Device) -> Bool) {
    return { device in
      let containExpectedDevice = device.name.contains(deviceFamily.rawValue)
      guard let isAvailable = isAvailable else { return containExpectedDevice }
      return (containExpectedDevice && isAvailable)
    }
  }

  /// <#Description#>
  /// - Parameter device: <#device description#>
  static public func filteriPhone(_ device : Device) -> Bool {
    return filterDeviceFamily(.iPhone, isAvailable: true)(device)
  }

}
