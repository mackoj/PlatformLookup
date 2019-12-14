import Foundation

extension PlatformLookup {
  /// <#Description#>
  public enum PlatformLookupError: Error, LocalizedError {
    case failedToInitializeDataIsNotValid
    case unknowDeviceFamilly(String)
    case noRuntimeFound
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
  }
}
