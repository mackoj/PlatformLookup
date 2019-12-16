import Foundation

extension PlatformLookup {
  // MARK: - Find Devices
  /// Cherche un device qui correspond a un nom précis
  /// - Parameters:
  ///   - deviceName: <#deviceName description#>
  ///   - version: <#version description#>
  static public func findAllDeviceNamed(_ deviceName: String, version: String? = nil) throws
    -> [Platform]
  {
    guard
      let deviceFamily = DeviceFamily.allCases.first(where: { deviceName.contains($0.rawValue) })
    else { throw (PlatformLookupError.unknowDeviceFamilly(deviceName)) }
    return try PlatformLookup.shared?.getAllDevices(
      with: filterDeviceName(deviceName),
      runtimeFilter: filterRuntime(deviceFamily.os, version: version)
    ) ?? []
  }

  /// Cherche un device qui correspond a un nom précis
  /// - Parameters:
  ///   - deviceName: <#deviceName description#>
  ///   - version: <#version description#>
  static public func findAllDevice(_ deviceFamily: DeviceFamily = .iPhone, version: String? = nil)
    throws -> [Platform]
  {
    return try PlatformLookup.shared?.getAllDevices(
      with: filterDeviceFamily(deviceFamily),
      runtimeFilter: filterRuntime(deviceFamily.os, version: version)
    ) ?? []
  }

  /// Trouve un device pour la derniere version de l'OS par default cherche un iPhone
  /// platform=\"iOS Simulator,name=iPhone 11 Pro Max,OS=13.2\"
  /// <#Description#>
  /// - Parameter deviceFamily: <#deviceFamily description#>
  static public func findADeviceForLastOSVersion(_ deviceFamily: DeviceFamily = .iPhone) throws
    -> String?
  {
    return try PlatformLookup.shared?.getPlatform(
      with: filterDeviceFamily(deviceFamily),
      runtimeFilter: filterRuntime(deviceFamily.os, version: nil)
    )
  }

  /// Trouve un device pour la derniere version de l'OS par default cherche un iPhone
  /// <#Description#>
  /// - Parameter deviceFamily: <#deviceFamily description#>
  static public func findADeviceForLastOSVersion(_ deviceFamily: DeviceFamily = .iPhone) throws
    -> Platform?
  {
    return try PlatformLookup.shared?.getPlatform(
      with: filterDeviceFamily(deviceFamily),
      runtimeFilter: filterRuntime(deviceFamily.os, version: nil)
    )
  }

  // MARK: - Private
  /// <#Description#>
  /// - Parameters:
  ///   - deviceFilter: <#deviceFilter description#>
  ///   - runtimeFilter: <#runtimeFilter description#>
  private func getPlatform(with deviceFilter: DeviceFilter, runtimeFilter: RuntimeFilter) throws
    -> String?
  {
    if let platform = try getAllDevices(with: deviceFilter, runtimeFilter: runtimeFilter).last {
      return "iOS Simulator,name=\(platform.devices.last!.name),OS=\(platform.runtime.version)"
    }
    throw PlatformLookupError.thisShouldNeverAppen(#function, #file, #line)
  }

  /// <#Description#>
  /// - Parameters:
  ///   - deviceFilter: <#deviceFilter description#>
  ///   - runtimeFilter: <#runtimeFilter description#>
  private func getPlatform(with deviceFilter: DeviceFilter, runtimeFilter: RuntimeFilter) throws
    -> Platform?
  { return try getAllDevices(with: deviceFilter, runtimeFilter: runtimeFilter).last }

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
      guard filteredDevices.count > 0 else { return nil }
      return Platform(runtime: runtime, devices: filteredDevices)
    }
  }
}
