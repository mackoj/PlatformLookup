import Foundation

extension PlatformLookup {
  /// <#Description#>
  public enum PlatformLookupError: Error, LocalizedError {
    case failedToInitializeDataIsNotValid
    case unknowDeviceFamilly(String)
    case noRuntimeFound
    case noDeviceFound
    case invalidIndex
    case thisShouldNeverAppen(String, String, Int)
    /// A localized message describing what error occurred.
    public var errorDescription: String? {
      switch self {
      case .invalidIndex:
        return NSLocalizedString("Invalid Index", comment: "Invalid Index")
      case .failedToInitializeDataIsNotValid:
        return NSLocalizedString(
          "Invalid data at initilisation of `PlatformLookup`",
          comment: "Invalid Data"
        )
      case .unknowDeviceFamilly(let input):
        return NSLocalizedString(
          "Device familly \(input) unknown",
          comment: "Unknown Device"
        )
      case .noRuntimeFound:
        return NSLocalizedString("Runtime unknown", comment: "Unknown Runtime")
      case .noDeviceFound:
        return NSLocalizedString("No device found", comment: "No device found")
      case .thisShouldNeverAppen(let function, let file, let line):
        let message =
          "This should really never happen please look at \(function) in \(file):\(line)"
        #if DEBUG
          assertionFailure(message)
        #endif
        return NSLocalizedString(message, comment: "Unknown Runtime")
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

    public var failedToInitializeDataIsNotValid: Void? {
      guard case .failedToInitializeDataIsNotValid = self else { return nil }
      return ()
    }

    public var unknowDeviceFamilly: String? {
      get {
        guard case let .unknowDeviceFamilly(value) = self else { return nil }
        return value
      }
      set {
        guard case .unknowDeviceFamilly = self, let newValue = newValue else {
          return
        }
        self = .unknowDeviceFamilly(newValue)
      }
    }

    public var noRuntimeFound: Void? {
      guard case .noRuntimeFound = self else { return nil }
      return ()
    }

    public var thisShouldNeverAppen: (String, String, Int)? {
      get {
        guard case let .thisShouldNeverAppen(value) = self else { return nil }
        return value
      }
      set {
        guard case .thisShouldNeverAppen = self, let newValue = newValue else {
          return
        }
        self = .thisShouldNeverAppen(newValue.0, newValue.1, newValue.2)
      }
    }
  }
}
