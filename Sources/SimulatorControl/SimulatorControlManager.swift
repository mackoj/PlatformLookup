//
//  File.swift
//  
//
//  Created by Jeffrey Macko on 04/11/2019.
//

import Foundation

public final class SimulatorControlManager {

  public enum DeviceFamily : String, CaseIterable {
    case iPhone = "iPhone"
    case iPad = "iPad"
    case appleTV = "Apple TV"
    case appleWatch = "Apple Watch"
    
    var os : String {
      get {
        switch self {
        case .iPhone, .iPad: return "iOS"
        case .appleTV: return "tvOS"
        case .appleWatch: return "watchOS"
        }
      }
    }
  }

  public typealias DeviceFilter = (_ device : Device) -> Bool
  public typealias RuntimeFilter = (_ device : Runtime) -> Bool
  let simctl : SimulatorControl
  private static var shared : SimulatorControlManager? = nil
  
  private init?(_ data: Data) {
    do {
      simctl = try JSONDecoder().decode(SimulatorControl.self, from: data)
    } catch {
      print(error)
      return nil
    }
  }
  
  private func _getPlatform(deviceFilter : DeviceFilter, runtimeFilter: RuntimeFilter) -> String? {
    if let platform = _getAllPlatform(deviceFilter, runtimeFilter: runtimeFilter).last {
      return """
      platform="iOS Simulator,name=\(platform.devices.last!.name),OS=\(platform.runtime.version)"
      """
    }
    return nil
  }
  
  private func _getPlatform(_ deviceFilter : DeviceFilter, runtimeFilter: RuntimeFilter) -> Platform? {
    return _getAllPlatform(deviceFilter, runtimeFilter: runtimeFilter).last
  }
  
  private func _getAllPlatform(_ deviceFilter : DeviceFilter, runtimeFilter: RuntimeFilter) -> [Platform] {
    guard let filteredRuntimes = simctl.runtimes?.filter(runtimeFilter) else { print("No runtime found"); return []; }
    let sortedRuntimes = filteredRuntimes.sorted(by: <)

    return sortedRuntimes.compactMap { (runtime) -> Platform? in
      let devices = simctl.devices?[runtime.identifier] ?? []
      let filteredDevices = devices.filter(deviceFilter)
      guard filteredDevices.count > 0 else { return nil }
      return Platform(runtime: runtime, devices: filteredDevices)
    }
  }
  
  /// <#Description#>
  /// - Parameter data: <#data description#>
  static public func instanciate(_ data: Data) {
    SimulatorControlManager.shared = SimulatorControlManager(data)
  }
  
  // MARK: Get Platform
  
  /// Last iPhone on Last os
  /// platform=\"iOS Simulator,name=iPhone 11 Pro Max,OS=13.2\"
  /// - Parameter deviceFilter: <#deviceFilter description#>
  static public func platform(_ deviceFamily : DeviceFamily = .iPhone) -> String? {
    return SimulatorControlManager.shared?._getPlatform(deviceFilter: filterDeviceFamily(deviceFamily), runtimeFilter: filterRuntime(deviceFamily.os, version: nil))
  }

  /// <#Description#>
  /// - Parameter deviceFilter: <#deviceFilter description#>
  static public func getMostRecentPlatform(_ deviceFamily : DeviceFamily = .iPhone) -> Platform? {
    return SimulatorControlManager.shared?._getPlatform(filterDeviceFamily(deviceFamily), runtimeFilter: filterRuntime(deviceFamily.os, version: nil))
  }

  /// <#Description#>
  /// - Parameter deviceFilter: <#deviceFilter description#>
  static public func getAllPlatform(_ deviceFamily : DeviceFamily, version : String? = nil) -> [Platform] {
    return SimulatorControlManager.shared?._getAllPlatform(filterDeviceFamily(deviceFamily), runtimeFilter: filterRuntime(deviceFamily.os, version: version)) ?? []
  }

  /// <#Description#>
  /// - Parameter deviceFilter: <#deviceFilter description#>
  static public func getAllPlatform(deviceName : String, version : String? = nil) -> [Platform] {
    guard let deviceFamily = DeviceFamily(rawValue: deviceName) else {
      print("Device name unknown")
      return []
    }
    return SimulatorControlManager.getAllPlatform(deviceFamily, version: version)
  }
  
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
