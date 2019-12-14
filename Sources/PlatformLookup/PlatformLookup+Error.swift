import Foundation

extension PlatformLookup {
  /// <#Description#>
  public enum PlatformLookupError: Error, LocalizedError {
    case failedToInitializeDataIsNotValid
    case unknowDeviceFamilly(String)
    case noRuntimeFound
    /// A localized message describing what error occurred.
    public var errorDescription: String? {
      switch self {
      case .failedToInitializeDataIsNotValid:
        return NSLocalizedString(
          "Invalid data at initilisation of `PlatformLookup`",
          comment: "Invalid Data"
        )
      case .unknowDeviceFamilly(let input):
        return NSLocalizedString("Device familly \(input) unknown", comment: "Unknown Device")
      case .noRuntimeFound: return NSLocalizedString("Runtime unknown", comment: "Unknown Runtime")
      }
    }
    /// A localized message describing the reason for the failure.
    public var failureReason: String? {
      return "failureReason"  //      switch self {
      //      case .failedToInitializeDataIsNotValid:
      //        <#code#>
      //      case .unknowDeviceFamilly(_):
      //        <#code#>
      //      case .noRuntimeFound:
      //        <#code#>
      //      }
    }
    /// A localized message describing how one might recover from the failure.
    public var recoverySuggestion: String? { return "failureReason" }
    /// A localized message providing "help" text if the user requests help.
    public var helpAnchor: String? { return "failureReason" }
  }
}
