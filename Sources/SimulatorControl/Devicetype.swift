import Foundation

/// <#Description#>
public struct Devicetype: Equatable, Codable {
  public let name: String
  public let bundlePath: String
  public let identifier: String

  /// <#Description#>
  /// - Parameters:
  ///   - name: <#name description#>
  ///   - bundlePath: <#bundlePath description#>
  ///   - identifier: <#identifier description#>
  public init(name: String, bundlePath: String, identifier: String) {
    self.name = name
    self.bundlePath = bundlePath
    self.identifier = identifier
  }
}
