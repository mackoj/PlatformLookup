import Foundation

extension PlatformLookup {
  /// <#Description#>
  public enum DeviceFamily: String, CaseIterable {
    case iPhone = "iPhone"
    case iPad = "iPad"
    case appleTV = "Apple TV"
    case appleWatch = "Apple Watch"
    /// <#Description#>
    var os: String {
      switch self {
      case .iPhone, .iPad: return "iOS"
      case .appleTV: return "tvOS"
      case .appleWatch: return "watchOS"
      }
    }
    var simulatorName: String {
      switch self {
      case .iPhone, .iPad: return "iOS Simulator"
      case .appleTV: return "tvOS Simulator"
      case .appleWatch: return "watchOS Simulator"
      }
    }
  }
}
