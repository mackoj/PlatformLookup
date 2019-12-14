//
//  File.swift
//  
//
//  Created by Jeffrey Macko on 04/11/2019.
//

import Foundation
import SimulatorControl
import Shell

public final class PlatformLookup {
  public typealias DeviceFilter = (_ device : Device) -> Bool
  public typealias RuntimeFilter = (_ device : Runtime) -> Bool
  static var shared = instanciate()
  let simctl : SimulatorControl

  static internal func instanciate(_ data: Data) {
    PlatformLookup.shared = PlatformLookup(data)
  }

  static private func instanciate() -> PlatformLookup? {
    let deviceList = shell("xcrun simctl list -j")
    return PlatformLookup(deviceList.data(using: .utf8))
  }

  private init?(_ data: Data?) {
    guard let data = data else { print("Data is not valid."); return nil; }
    do {
      simctl = try JSONDecoder().decode(SimulatorControl.self, from: data)
    } catch {
      print(error)
      return nil
    }
  }
}
