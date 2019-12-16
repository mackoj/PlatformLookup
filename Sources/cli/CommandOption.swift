import Foundation

enum OSVersionCommand {
  case version(String)
  case lastOS

  var version: String? {
    get {
      guard case let .version(value) = self else { return nil }
      return value
    }
    set {
      guard case .version = self, let newValue = newValue else { return }
      self = .version(newValue)
    }
  }

  var lastOS: Void? {
    guard case .lastOS = self else { return nil }
    return ()
  }
}

enum CommandOption {
  enum CommandError: Error { case toto }
  case name(String)
  case osVersion(OSVersionCommand)
  case version
  case help
  init(arguments: [String]) throws {
    let (parser, binder) = (kArgParser, kArgBinder)
    let result = try parser.parse(arguments)
    var command = CommandOption.help
    try binder.fill(parseResult: result, into: &command)
    self = command
  }

  var name: String? {
    get {
      guard case let .name(value) = self else { return nil }
      return value
    }
    set {
      guard case .name = self, let newValue = newValue else { return }
      self = .name(newValue)
    }
  }

  var osVersion: OSVersionCommand? {
    get {
      guard case let .osVersion(value) = self else { return nil }
      return value
    }
    set {
      guard case .osVersion = self, let newValue = newValue else { return }
      self = .osVersion(newValue)
    }
  }

  var version: Void? {
    guard case .version = self else { return nil }
    return ()
  }

  var help: Void? {
    guard case .help = self else { return nil }
    return ()
  }
}
