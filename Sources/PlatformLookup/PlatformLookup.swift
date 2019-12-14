import Foundation
import Shell
import SimulatorControl

public final class PlatformLookup {
  public enum PlatformLookupError: Error {
    case failedToInitializeDataIsNotValid
  }

  public typealias DeviceFilter = (_ device: Device) -> Bool
  public typealias RuntimeFilter = (_ device: Runtime) -> Bool
  static var shared = try? instanciate()
  let simctl: SimulatorControl

  static internal func instanciate(_ data: Data) throws {
    PlatformLookup.shared = try PlatformLookup(data)
  }

  static private func instanciate() throws -> PlatformLookup? {
    let deviceList = try shell("xcrun simctl list -j")
    return try PlatformLookup(deviceList.data(using: .utf8))
  }

  private init(_ data: Data?) throws {
    guard let data = data else { throw (PlatformLookupError.failedToInitializeDataIsNotValid) }

    simctl = try JSONDecoder().decode(SimulatorControl.self, from: data)
  }
}
