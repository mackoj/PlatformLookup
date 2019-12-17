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
      case .appleWatch: return ["watch", "apple watch"]
      }
    }
    public init?(rawValue input: String) {
      let lowercasedInput = input.lowercased()
      let filteredResult = DeviceFamily.allCases.filter { (it) -> Bool in
        return DeviceFamily.variantes(it).contains { lowercasedInput.contains($0.lowercased()) }
      }
      if let first = filteredResult.first { self = first }
      else { return nil }
    }

    /// <#Description#>
    var os: String {
      switch self {
      case .iPhone, .iPad: return "iOS"
      case .tv: return "tvOS"
      case .watch: return "watchOS"
      }
    }
    var simulatorName: String {
      switch self {
      case .iPhone, .iPad: return "iOS Simulator"
      case .tv: return "tvOS Simulator"
      case .watch: return "watchOS Simulator"
      }
    }
  }
}
