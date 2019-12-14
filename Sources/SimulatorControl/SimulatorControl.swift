import Foundation

/// <#Description#>
public struct SimulatorControl: Equatable, Codable {
  public let devicetypes: [Devicetype]?
  public let runtimes: [Runtime]?
  public let devices: [String: [Device]]?
  public let pairs: [String: Pair]?

  public init(
    devicetypes: [Devicetype]?,
    runtimes: [Runtime]?,
    devices: [String: [Device]]?,
    pairs: [String: Pair]?
  ) {
    self.devicetypes = devicetypes
    self.runtimes = runtimes
    self.devices = devices
    self.pairs = pairs
  }
}
