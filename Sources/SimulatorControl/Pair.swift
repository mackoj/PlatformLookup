import Foundation

/// <#Description#>
public struct Pair: Equatable, Codable {
  public let watch: Device?
  public let phone: Device?
  public let state: String?

  /// <#Description#>
  /// - Parameters:
  ///   - watch: <#watch description#>
  ///   - phone: <#phone description#>
  ///   - state: <#state description#>
  public init(watch: Device?, phone: Device?, state: String?) {
    self.watch = watch
    self.phone = phone
    self.state = state
  }
}
