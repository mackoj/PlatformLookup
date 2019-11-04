import Foundation

// MARK: - Pair
public struct Pair: Equatable, Codable {
  public let watch: Device?
  public let phone: Device?
  public let state: String?
  
  public init(
    watch: Device?,
    phone: Device?,
    state: String?
  ) {
    self.watch = watch
    self.phone = phone
    self.state = state
  }
}
