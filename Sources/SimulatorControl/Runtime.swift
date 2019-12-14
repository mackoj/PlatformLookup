import Foundation
import Version

// MARK: - Runtime
public struct Runtime: Equatable, Codable {
  public let version: String
  public let bundlePath: String
  public let isAvailable: Bool
  public let name: String
  public let identifier: String
  public let buildversion: String

  public init(
    version: String,
    bundlePath: String,
    isAvailable: Bool,
    name: String,
    identifier: String,
    buildversion: String
  ) {
    self.version = version
    self.bundlePath = bundlePath
    self.isAvailable = isAvailable
    self.name = name
    self.identifier = identifier
    self.buildversion = buildversion
  }
}

extension Runtime: Comparable {
  public static func < (lhs: Runtime, rhs: Runtime) -> Bool {
    return lhs.convertedVersion < rhs.convertedVersion
  }

  public static func > (lhs: Runtime, rhs: Runtime) -> Bool {
    return lhs.convertedVersion > rhs.convertedVersion
  }
}

extension Runtime { var convertedVersion: Version { Version(version)! } }
