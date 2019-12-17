import Foundation

/// <#Description#>
public struct Device: Equatable, Codable {
  public let state: String
  public let isAvailable: Bool?
  public let name: String
  public let udid: String
  public let availabilityError: String?

  /// <#Description#>
  /// - Parameters:
  ///   - state: <#state description#>
  ///   - isAvailable: <#isAvailable description#>
  ///   - name: <#name description#>
  ///   - udid: <#udid description#>
  ///   - availabilityError: <#availabilityError description#>
  public init(
    state: String,
    isAvailable: Bool?,
    name: String,
    udid: String,
    availabilityError: String?
  ) {
    self.state = state
    self.isAvailable = isAvailable
    self.name = name
    self.udid = udid
    self.availabilityError = availabilityError
  }
}
