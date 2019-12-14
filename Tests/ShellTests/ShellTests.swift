import SnapshotTesting
import XCTest

@testable import Shell

final class ShellTests: XCTestCase {
  func test_SimpleTest() {
    do {
      try shell("touch testFile.txt")
      let lsOutput = try shell("ls testFile.txt")
      assertSnapshot(matching: lsOutput, as: .description)
    } catch { XCTAssert(false, error.localizedDescription) }
  }

  static var allTests = [("test_SimpleTest", test_SimpleTest),]
}
