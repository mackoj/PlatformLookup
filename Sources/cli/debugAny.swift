import Foundation
import SimulatorControl

extension Device: CustomStringConvertible {
  public var description: String { return DebugAny.snap(self) }
}

struct DebugAny {
  static func snap<T>(_ value: T, name: String? = nil, indent: Int = 0) -> String {
    let indentation = String(repeating: " ", count: indent)
    let mirror = Mirror(reflecting: value)
    var children = mirror.children
    let count = children.count
    let bullet = count == 0 ? "-" : "▿"
    let description: String
    switch (value, mirror.displayStyle) {
    case (_, .collection?): description = count == 1 ? "1 element" : "\(count) elements"
    case (_, .dictionary?):
      description = count == 1 ? "1 key/value pair" : "\(count) key/value pairs"
      children = sort(children)
    case (_, .set?):
      description = count == 1 ? "1 member" : "\(count) members"
      children = sort(children)
    case (_, .tuple?): description = count == 1 ? "(1 element)" : "(\(count) elements)"
    case (_, .optional?):
      let subjectType = String(describing: mirror.subjectType).replacingOccurrences(
        of: " #\\d+",
        with: "",
        options: .regularExpression
      )
      description = count == 0 ? "\(subjectType).none" : "\(subjectType)"
    //    case (let value as AnySnapshotStringConvertible, _) where type(of: value).renderChildren:
    //      description = value.snapshotDescription
    //    case (let value as AnySnapshotStringConvertible, _):
    //      return "\(indentation)- \(name.map { "\($0): " } ?? "")\(value.snapshotDescription)\n"
    //    case (let value as CustomStringConvertible, _):
    //      description = value.description
    case (_, .class?), (_, .struct?):
      description = String(describing: mirror.subjectType).replacingOccurrences(
        of: " #\\d+",
        with: "",
        options: .regularExpression
      )
      children = sort(children)
    case (_, .enum?):
      let subjectType = String(describing: mirror.subjectType).replacingOccurrences(
        of: " #\\d+",
        with: "",
        options: .regularExpression
      )
      description = count == 0 ? "\(subjectType).\(value)" : "\(subjectType)"
    case (let value, _): description = String(describing: value)
    }
    let lines = ["\(indentation)\(bullet) \(name.map { "\($0): " } ?? "")\(description)\n"]
      + children.map { snap($1, name: $0, indent: indent + 2) }
    return lines.joined()
  }
  static func sort(_ children: Mirror.Children) -> Mirror.Children {
    return .init(
      children.map({ (child: $0, snap: snap($0)) }).sorted(by: { $0.snap < $1.snap }).map({
        $0.child
      })
    )
  }
}
