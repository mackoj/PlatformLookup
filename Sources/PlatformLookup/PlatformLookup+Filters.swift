import Foundation
import SimulatorControl

extension PlatformLookup {

  public typealias DeviceFilterCompletion = (Device) -> Bool
  public typealias RuntimeFilterCompletion = (Runtime) -> Bool

  // MARK: - Runtime Filter
  /// <#Description#>
  /// - Parameters:
  ///   - name: <#name description#>
  ///   - version: <#version description#>
  static public func filterRuntime(_ name: String, version: String? = nil) -> (
    RuntimeFilterCompletion
  ) {
    return { runtime in let f1 = runtime.name.contains(name)
      guard let version = version else { return f1 }
      return f1 && runtime.version.contains(version)
    }
  }

  // MARK: - Device Filter
  /// <#Description#>
  /// - Parameter deviceName: <#deviceName description#>
  static public func filterDeviceName(_ deviceName: String) -> (DeviceFilterCompletion) {
    return { $0.name.lowercased().contains(deviceName.lowercased()) }
  }
  /// <#Description#>
  /// - Parameters:
  ///   - deviceFamily: <#deviceFamily description#>
  ///   - isAvailable: <#isAvailable description#>
  static public func filterDeviceFamily(_ deviceFamily: DeviceFamily, isAvailable: Bool? = nil) -> (
    DeviceFilterCompletion
  ) {
    return { device in let containExpectedDevice = device.name.contains(deviceFamily.rawValue)
      guard let isAvailable = isAvailable else { return containExpectedDevice }
      return (containExpectedDevice && isAvailable)
    }
  }
  /// <#Description#>
  /// - Parameter device: <#device description#>
  static public func filteriPhone() -> (DeviceFilterCompletion) {
    return filterDeviceFamily(.iPhone, isAvailable: true)
  }
}
