import Foundation

extension PlatformLookup {
  /// <#Description#>
  public enum PlatformLookupError: Error, LocalizedError {
    case failedToInitializeDataIsNotValid
    case invalidIndex(file: String, function: String, line: Int)
    case noResultForThisCombinaison(device: String, runtime: String)
    case noRuntimeFound
    case thisShouldNeverAppen(file: String, function: String, line: Int)
    case unknowDevice(String)
    case unknowRuntime(String)
    case impossibleConfiguration(String)
    /// A localized message describing what error occurred.
    public var errorDescription: String? {
      switch self {
      case .failedToInitializeDataIsNotValid:
        return NSLocalizedString(
          "Invalid data at initilisation of `PlatformLookup`",
          comment: "Invalid Data"
        )
      case .invalidIndex(let file, let function, let line):
        return NSLocalizedString(
          "Invalid Index at \(function) in \(file):\(line)",
          comment: "Invalid Index"
        )
      case .noResultForThisCombinaison(let device, let runtime):
        return NSLocalizedString(
          "No result found for device: \(device), runtime: \(runtime)",
          comment: "Invalid device/runtime combinaison"
        )
      case .noRuntimeFound:
        return NSLocalizedString("No runtime found", comment: "No runtime found")
      case .thisShouldNeverAppen(let file, let function, let line):
        let message =
          "This should really never happen please look at \(function) in \(file):\(line)"
        #if DEBUG
          assertionFailure(message)
        #endif
        return NSLocalizedString(message, comment: "Unknown Runtime")
      case .unknowDevice(let device):
        return NSLocalizedString("Unknown device: \(device)", comment: "unknown device")
      case .unknowRuntime(let runtime):
        return NSLocalizedString("Unknown runtime: \(runtime)", comment: "Unknown runtime")
      case .impossibleConfiguration(let configuration):
        return NSLocalizedString(
          "This configuration can't work: \(configuration)",
          comment: "This configuration can't work"
        )
      }
    }
    /// A localized message describing the reason for the failure.
    public var failureReason: String? { return "failureReason - need to be implemented" }
    /// A localized message describing how one might recover from the failure.
    public var recoverySuggestion: String? { return "recoverySuggestion - need to be implemented" }
    /// A localized message providing "help" text if the user requests help.
    public var helpAnchor: String? { return "helpAnchor - need to be implemented" }
    public var invalidIndex: (file: String, function: String, line: Int)? {
      get {
        guard case let .invalidIndex(value) = self else { return nil }
        return value
      }
      set {
        guard case .invalidIndex = self, let newValue = newValue else { return }
        self = .invalidIndex(file: newValue.0, function: newValue.1, line: newValue.2)
      }
    }
    public var noResultForThisCombinaison: (device: String, runtime: String)? {
      get {
        guard case let .noResultForThisCombinaison(value) = self else { return nil }
        return value
      }
      set {
        guard case .noResultForThisCombinaison = self, let newValue = newValue else { return }
        self = .noResultForThisCombinaison(device: newValue.0, runtime: newValue.1)
      }
    }
    public var thisShouldNeverAppen: (file: String, function: String, line: Int)? {
      get {
        guard case let .thisShouldNeverAppen(value) = self else { return nil }
        return value
      }
      set {
        guard case .thisShouldNeverAppen = self, let newValue = newValue else { return }
        self = .thisShouldNeverAppen(file: newValue.0, function: newValue.1, line: newValue.2)
      }
    }
    public var unknowDevice: String? {
      get {
        guard case let .unknowDevice(value) = self else { return nil }
        return value
      }
      set {
        guard case .unknowDevice = self, let newValue = newValue else { return }
        self = .unknowDevice(newValue)
      }
    }
    public var unknowRuntime: String? {
      get {
        guard case let .unknowRuntime(value) = self else { return nil }
        return value
      }
      set {
        guard case .unknowRuntime = self, let newValue = newValue else { return }
        self = .unknowRuntime(newValue)
      }
    }
    public var impossibleConfiguration: String? {
      get {
        guard case let .impossibleConfiguration(value) = self else { return nil }
        return value
      }
      set {
        guard case .impossibleConfiguration = self, let newValue = newValue else { return }
        self = .impossibleConfiguration(newValue)
      }
    }
  }
}
