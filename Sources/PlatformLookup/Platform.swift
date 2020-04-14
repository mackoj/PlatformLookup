import Foundation
import NonEmpty
import SimulatorControl

/// <#Description#>
public struct Platform: Equatable, Codable {
  public let devices: NonEmptyArray<Device>
  public let runtime: Runtime

  /// <#Description#>
  /// - Parameters:
  ///   - runtime: <#runtime description#>
  ///   - device: <#device description#>
  init(runtime: Runtime, device: Device) {
    self.devices = NonEmptyArray<Device>(device)
    self.runtime = runtime
  }

  /// <#Description#>
  /// - Parameters:
  ///   - runtime: <#runtime description#>
  ///   - devices: <#devices description#>
  init(runtime: Runtime, devices: NonEmptyArray<Device>) {
    self.devices = devices
    self.runtime = runtime
  }
}
