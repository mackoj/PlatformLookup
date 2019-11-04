//
//  File.swift
//  
//
//  Created by Jeffrey Macko on 04/11/2019.
//

import Foundation

public final class SimulatorControlManager {
  
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
    let runtimesSorted = simctl.runtimes?.sorted(by: >)
    guard let identifier = runtimesSorted?.first?.identifier else { return nil }
    let devices = simctl.devices?[identifier]!
    let iPhones = devices?.filter(filterDeviceThatAreIphoneAndAvailable)
    if let finalDevice = iPhones?.last, let version = runtimesSorted?.first?.version {
      return "platform=iOS Simulator,name=\(finalDevice.name),OS=\(version)"
    }
    return nil
  }
}
