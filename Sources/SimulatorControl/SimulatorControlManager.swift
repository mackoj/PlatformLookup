//
//  File.swift
//  
//
//  Created by Jeffrey Macko on 04/11/2019.
//

import Foundation

public struct Platform {
  let device: Device
  let runtime: Runtime
}

public final class SimulatorControlManager {
  
  typealias DeviceFilter = (_ device : Device) -> Bool
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
  
  static public func instanciate(_ data: Data) {
    SimulatorControlManager.shared = SimulatorControlManager(data)
  }
  
  static public func getPlatform() -> String? {
    return SimulatorControlManager.shared?.getPlatform()
  }
  
  private func filterDeviceThatAreIphoneAndAvailable(_ device : Device) -> Bool {
    let isIphone = device.name.contains("iPhone")
    let isAvailable = device.isAvailable ?? false
    return (isIphone && isAvailable)
  }
  
  private func getPlatform() -> String? {
    if let platform : Platform = getPlatform(filterDeviceThatAreIphoneAndAvailable) {
      return "platform=\"iOS Simulator,name=\(platform.device.name),OS=\(platform.runtime.version)\""
    }
    return nil
  }
  
  private func getPlatform(_ deviceFilter : DeviceFilter) -> Platform? {
    let runtimesSorted = simctl.runtimes?.sorted(by: >)
    guard
      let runtime = runtimesSorted?.first,
      let devices = simctl.devices?[runtime.identifier]
      else { return nil }

    let filteredDevice = devices.filter(deviceFilter)
    if let finalDevice = filteredDevice.last {
      return Platform(device: finalDevice, runtime: runtime)
    }
    return nil
  }
}
