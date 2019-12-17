import Foundation
import SimulatorControl
import PlatformLookup

extension Device: CustomStringConvertible {
  public var description: String { return DebugAny.snap(self) }
}
extension Devicetype: CustomStringConvertible {
  public var description: String { return DebugAny.snap(self) }
}
extension Pair: CustomStringConvertible {
  public var description: String { return DebugAny.snap(self) }
}
extension Runtime: CustomStringConvertible {
  public var description: String { return DebugAny.snap(self) }
}
extension SimulatorControl: CustomStringConvertible {
  public var description: String { return DebugAny.snap(self) }
}
extension Platform: CustomStringConvertible {
  public var description: String { return DebugAny.snap(self) }
}
