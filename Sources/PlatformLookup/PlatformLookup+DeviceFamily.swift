import Foundation

extension PlatformLookup {
  /// <#Description#>
  public enum DeviceFamily: String, RawRepresentable, CaseIterable {
    case iPhone = "iPhone"
    case iPad = "iPad"
    case appleTV = "Apple TV"
    case appleWatch = "Apple Watch"
    static func variantes(_ deviceFamily: DeviceFamily) -> [String] {
      switch deviceFamily {
      case .iPhone: return ["iPhone"]
      case .iPad: return ["iPad"]
      case .appleTV: return ["tv", "apple tv"]
      case .appleWatch: return ["watch", "apple watch", "series"]
      }
    }
    public init?(rawValue input: String) {
      let lowercasedInput = input.lowercased()
      let filteredResult = DeviceFamily.allCases.filter { (it) -> Bool in
        return DeviceFamily.variantes(it).contains { lowercasedInput.contains($0.lowercased()) }
      }
      if let first = filteredResult.first { self = first } else { return nil }
    }

    /// <#Description#>
    public var os: String {
      switch self {
      case .iPhone, .iPad: return "iOS"
      case .appleTV: return "tvOS"
      case .appleWatch: return "watchOS"
      }
    }
    public var simulatorName: String {
      switch self {
      case .iPhone, .iPad: return "iOS Simulator"
      case .appleTV: return "tvOS Simulator"
      case .appleWatch: return "watchOS Simulator"
      }
    }
  }
}
