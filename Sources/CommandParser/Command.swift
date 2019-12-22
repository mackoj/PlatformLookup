import Foundation
import PlatformLookup

/// <#Description#>
public struct Command {
  public let name: String
  public let runtimeVersion: String?
  public let showAll: Bool
  public let version: Bool
  public let help: Bool
  /// <#Description#>
  /// - Parameter args: <#args description#>
  public init(_ args: [String]) throws {
    var arguments = args
    var pRuntimeVersion: String?
    var pName: String?
    var pShowAll: Bool = false
    var pVersion: Bool = false
    var pHelp: Bool = false
    while arguments.isEmpty == false {
      let arg = arguments.removeFirst()
      switch arg {
      case "--version": pVersion = true
      case "--help": pHelp = true
      case "-v": pRuntimeVersion = arguments.removeFirst()
      case "-s": pShowAll = true
      default: pName = arg
      }
    }
    guard let localName = pName else { throw (Overview) }
    self.name = localName
    self.runtimeVersion = pRuntimeVersion
    self.showAll = pShowAll
    self.version = pVersion
    self.help = pHelp
  }
}
