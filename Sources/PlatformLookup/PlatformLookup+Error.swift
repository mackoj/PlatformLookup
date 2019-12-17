import Foundation

extension PlatformLookup {
  /// <#Description#>
  public enum PlatformLookupError: Error, LocalizedError {
    case failedToInitializeDataIsNotValid
    case invalidIndex(file: String, function: String, line: Int)
    case noResultForThisCombinaison(device: String, runtime: String)
    case noRuntimeFound
    case thisShouldNeverAppen(file: String, function: String, line: Int)
    case unknow(device: String)
    case unknow(runtime: String)
    /// A localized message describing what error occurred.
    public var errorDescription: String? {
      switch self {  //      case .invalidIndex:
      //        return NSLocalizedString("Invalid Index", comment: "Invalid Index")
      //      case .failedToInitializeDataIsNotValid:
      //        return NSLocalizedString(
      //          "Invalid data at initilisation of `PlatformLookup`",
      //          comment: "Invalid Data"
      //        )
      //      case .unknow(let input):
      //        return NSLocalizedString(
      //          "Device familly \(input) unknown",
      //          comment: "Unknown Device"
      //        )
      //      case .noRuntimeFound:
      //        return NSLocalizedString("Runtime unknown", comment: "Unknown Runtime")
      //      case .noDeviceFound:
      //        return NSLocalizedString("No device found", comment: "No device found")
      //      case .thisShouldNeverAppen(let function, let file, let line):
      //        let message =
      //        "This should really never happen please look at \(function) in \(file):\(line)"
      //        #if DEBUG
      //        assertionFailure(message)
      //        #endif
      //        return NSLocalizedString(message, comment: "Unknown Runtime")
      }
    }
    /// A localized message describing the reason for the failure.
    public var failureReason: String? {
      return "failureReason - need to be implemented"
    }
    /// A localized message describing how one might recover from the failure.
    public var recoverySuggestion: String? {
      return "recoverySuggestion - need to be implemented"
    }
    /// A localized message providing "help" text if the user requests help.
    public var helpAnchor: String? {
      return "helpAnchor - need to be implemented"
    }
  }
}
