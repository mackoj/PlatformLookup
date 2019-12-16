import Foundation
import Shell
import SimulatorControl

/// <#Description#>
public final class PlatformLookup {
  /// <#Description#>
  public typealias DeviceFilter = (_ device: Device) -> Bool
  /// <#Description#>
  public typealias RuntimeFilter = (_ device: Runtime) -> Bool
  /// <#Description#>
  static var shared = try? instanciate()
  /// <#Description#>
  let simctl: SimulatorControl
  /// <#Description#>
  /// - Parameter data: <#data description#>
  static internal func instanciate(_ data: Data) throws {
    PlatformLookup.shared = try PlatformLookup(data)
  }
  /// <#Description#>
  static private func instanciate() throws -> PlatformLookup? {
    let deviceList = try shell("xcrun simctl list -j")
    return try PlatformLookup(deviceList.data(using: .utf8))
  }

  /// <#Description#>
  /// - Parameter data: <#data description#>
  internal init(_ data: Data?) throws {
    guard let data = data else {
      throw (PlatformLookupError.failedToInitializeDataIsNotValid)
    }

    simctl = try JSONDecoder().decode(SimulatorControl.self, from: data)
  }
}
