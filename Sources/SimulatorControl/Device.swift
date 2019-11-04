import Foundation

// MARK: - Device
public struct Device: Equatable, Codable {
  public let state: String
  public let isAvailable: Bool?
  public let name: String
  public let udid: String
  public let availabilityError: String?
  
  public init(
    state: String,
    isAvailable: Bool?,
    name: String,
    udid: String,
    availabilityError: String?
  ) {
    self.state = state
    self.isAvailable = isAvailable ?? false
    self.name = name
    self.udid = udid
    self.availabilityError = availabilityError
  }
}
