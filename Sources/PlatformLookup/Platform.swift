import Foundation
import SimulatorControl

/// <#Description#>
public struct Platform: Equatable, Codable {
  let devices: [Device]
  let runtime: Runtime

  /// <#Description#>
  /// - Parameters:
  ///   - runtime: <#runtime description#>
  ///   - device: <#device description#>
  init(runtime: Runtime, device: Device) {
    self.devices = [device]
    self.runtime = runtime
  }

  /// <#Description#>
  /// - Parameters:
  ///   - runtime: <#runtime description#>
  ///   - devices: <#devices description#>
  init(runtime: Runtime, devices: [Device]) {
    self.devices = devices
    self.runtime = runtime
  }
}
