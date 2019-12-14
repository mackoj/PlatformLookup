import Foundation

extension PlatformLookup {
  public enum DeviceFamily: String, CaseIterable {
    case iPhone = "iPhone"
    case iPad = "iPad"
    case appleTV = "Apple TV"
    case appleWatch = "Apple Watch"

    var os: String {
      switch self {
      case .iPhone, .iPad: return "iOS"
      case .appleTV: return "tvOS"
      case .appleWatch: return "watchOS"
      }
    }
  }
}
