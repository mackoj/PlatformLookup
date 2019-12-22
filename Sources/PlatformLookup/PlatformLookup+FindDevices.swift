import Foundation
import SimulatorControl

extension PlatformLookup {
  static public func deviceFamilyFrom(_ deviceName: String) throws -> DeviceFamily {
    guard let deviceFamily = DeviceFamily(rawValue: deviceName) else {
      throw (PlatformLookupError.unknowDevice(deviceName))
    }
    return deviceFamily
  }
  // MARK: - Find Devices
  /// Cherche un device qui correspond a un nom précis
  /// - Parameters:
  ///   - deviceName: <#deviceName description#>
  ///   - version: <#version description#>
  static public func findAllDeviceNamed(_ deviceName: String, version: String? = nil) throws
    -> [Platform]
  {
    let deviceFamily = try deviceFamilyFrom(deviceName)
    let platforms = try PlatformLookup.shared?.getAllDevices(
      with: filterDeviceName(deviceName),
      runtimeFilter: filterRuntime(deviceFamily.os, version: version)
    )
    guard let validPlatforms = platforms, validPlatforms.isEmpty == false else {
      throw (
        PlatformLookupError.noResultForThisCombinaison(
          device: deviceName,
          runtime: "os: \(deviceFamily.os), version: \(version ?? "<not defined>")"
        )
      )
    }
    return validPlatforms
  }

  /// Cherche un device qui correspond a un nom précis
  /// - Parameters:
  ///   - deviceName: <#deviceName description#>
  ///   - version: <#version description#>
  static public func findAllDevice(_ deviceFamily: DeviceFamily = .iPhone, version: String? = nil)
    throws -> [Platform]
  {
    let platforms = try PlatformLookup.shared?.getAllDevices(
      with: filterDeviceFamily(deviceFamily),
      runtimeFilter: filterRuntime(deviceFamily.os, version: version)
    )
    guard let validPlatforms = platforms, validPlatforms.isEmpty == false else {
      throw (
        PlatformLookupError.noResultForThisCombinaison(
          device: deviceFamily.rawValue,
          runtime: "os: \(deviceFamily.os), version: \(version ?? "<not defined>")"
        )
      )
    }
    return validPlatforms
  }

  /// Trouve un device pour la derniere version de l'OS par default cherche un iPhone
  /// <#Description#>
  /// - Parameter deviceFamily: <#deviceFamily description#>
  static public func findADeviceForLastOSVersion(_ deviceFamily: DeviceFamily) throws -> Platform {
    let platform = try PlatformLookup.shared?.getAllDevices(
      with: filterDeviceFamily(deviceFamily),
      runtimeFilter: filterRuntime(deviceFamily.os, version: nil)
    ).last
    guard let validPlatform = platform else {
      throw (
        PlatformLookupError.noResultForThisCombinaison(
          device: deviceFamily.rawValue,
          runtime: "os: \(deviceFamily.os), version: <not defined>"
        )
      )
    }
    return validPlatform
  }
  // MARK: - Platform
  /// <#Description#>
  /// - Parameters:
  ///   - platform: <#platform description#>
  ///   - deviceIndex: <#deviceIndex description#>
  static public func format(
    _ platform: Platform,
    deviceFamily: DeviceFamily,
    deviceIndex: Int? = nil
  ) throws -> String {
    let device: Device
    if let idx = deviceIndex { device = platform.devices[idx] }
    else { device = platform.devices.last! }
    return "\(deviceFamily.simulatorName),name=\(device.name),OS=\(platform.runtime.version)"
  }
  // MARK: - Private
  /// <#Description#>
  /// - Parameters:
  ///   - deviceFilter: <#deviceFilter description#>
  ///   - runtimeFilter: <#runtimeFilter description#>
  private func getAllDevices(with deviceFilter: DeviceFilter, runtimeFilter: RuntimeFilter) throws
    -> [Platform]
  {
    guard let filteredRuntimes = simctl.runtimes?.filter(runtimeFilter), filteredRuntimes.count > 0
    else { throw (PlatformLookupError.noRuntimeFound) }
    let sortedRuntimes = filteredRuntimes.sorted(by: <)

    return sortedRuntimes.compactMap { (runtime) -> Platform? in
      let devices = simctl.devices?[runtime.identifier] ?? []
      let filteredDevices = devices.filter(deviceFilter)
      guard filteredDevices.isEmpty == false else { return nil }
      return Platform(runtime: runtime, devices: filteredDevices)
    }
  }
}
