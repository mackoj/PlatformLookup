//
//  File.swift
//  
//
//  Created by Jeffrey Macko on 26/11/2019.
//

import Foundation
import SimulatorControl

public struct Platform : Equatable, Codable {
  let devices: [Device]
  let runtime: Runtime
  
  init(runtime: Runtime, device : Device) {
    self.devices = [device]
    self.runtime = runtime
  }

  init(runtime: Runtime, devices : [Device]) {
    self.devices = devices
    self.runtime = runtime
  }
}
