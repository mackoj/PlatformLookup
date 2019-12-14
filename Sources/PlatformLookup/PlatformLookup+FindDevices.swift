import Foundation

extension PlatformLookup {
  // MARK: Find Devices

  /// Trouve un device pour la derniere version de l'OS par default cherche un iPhone
  /// platform=\"iOS Simulator,name=iPhone 11 Pro Max,OS=13.2\"
  /// - Parameter deviceFilter: <#deviceFilter description#>
  static public func findADeviceForLastOSVersion(_ deviceFamily: DeviceFamily = .iPhone) -> String?
  {
    return PlatformLookup.shared?.getPlatform(
      with: filterDeviceFamily(deviceFamily),
      runtimeFilter: filterRuntime(deviceFamily.os, version: nil))
  }

  /// Trouve un device pour la derniere version de l'OS par default cherche un iPhone
  /// - Parameter deviceFilter: <#deviceFilter description#>
  static public func findADeviceForLastOSVersion(_ deviceFamily: DeviceFamily = .iPhone)
    -> Platform?
  {
    return PlatformLookup.shared?.getPlatform(
      with: filterDeviceFamily(deviceFamily),
      runtimeFilter: filterRuntime(deviceFamily.os, version: nil))
  }

  /// Trouve tous les devices pour une version d'os
  /// - Parameter deviceFilter: <#deviceFilter description#>
  static public func findAllDevicesForAnOSVersion(
    _ deviceFamily: DeviceFamily, version: String? = nil
  ) -> [Platform] {
    return PlatformLookup.shared?.getAllDevices(
      with: filterDeviceFamily(deviceFamily),
      runtimeFilter: filterRuntime(deviceFamily.os, version: version)) ?? []
  }

  /// Trouve tous les devices pour une version d'os
  /// - Parameter deviceFilter: <#deviceFilter description#>
  static public func findAllDevicesForAnOSVersion(deviceName: String, version: String? = nil)
    -> [Platform]
  {
    guard let deviceFamily = DeviceFamily(rawValue: deviceName) else {
      print("Device name unknown")
      return []
    }
    return PlatformLookup.findAllDevicesForAnOSVersion(deviceFamily, version: version)
  }

  // MARK: Private

  private func getPlatform(with deviceFilter: DeviceFilter, runtimeFilter: RuntimeFilter) -> String?
  {
    if let platform = getAllDevices(with: deviceFilter, runtimeFilter: runtimeFilter).last {
      return """
        platform="iOS Simulator,name=\(platform.devices.last!.name),OS=\(platform.runtime.version)"
        """
    }
    return nil
  }

  private func getPlatform(with deviceFilter: DeviceFilter, runtimeFilter: RuntimeFilter)
    -> Platform?
  {
    return getAllDevices(with: deviceFilter, runtimeFilter: runtimeFilter).last
  }

  private func getAllDevices(with deviceFilter: DeviceFilter, runtimeFilter: RuntimeFilter)
    -> [Platform]
  {
    guard let filteredRuntimes = simctl.runtimes?.filter(runtimeFilter) else {
      print("No runtime found")
      return []
    }
    let sortedRuntimes = filteredRuntimes.sorted(by: <)

    return sortedRuntimes.compactMap { (runtime) -> Platform? in
      let devices = simctl.devices?[runtime.identifier] ?? []
      let filteredDevices = devices.filter(deviceFilter)
      guard filteredDevices.count > 0 else { return nil }
      return Platform(runtime: runtime, devices: filteredDevices)
    }
  }
}
