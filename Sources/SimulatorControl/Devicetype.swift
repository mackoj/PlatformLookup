import Foundation

// MARK: - Devicetype
public struct Devicetype: Equatable, Codable {
  public let name: String
  public let bundlePath: String
  public let identifier: String

  public init(
    name: String,
    bundlePath: String,
    identifier: String
  ) {
    self.name = name
    self.bundlePath = bundlePath
    self.identifier = identifier
  }
}
