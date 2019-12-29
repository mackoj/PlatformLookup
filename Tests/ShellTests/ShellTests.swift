import XCTest

@testable import Shell

final class ShellTests: XCTestCase {
  func test_SimpleTest() {
    do {
      try shell("touch testFile.txt")
      var lsOutput = try shell("ls testFile.txt")
      // remove the \n
      _ = lsOutput.removeLast()
      XCTAssertEqual(lsOutput, "testFile.txt")
      _ = try shell("rm testFile.txt")
    }
    catch { XCTAssert(false, error.localizedDescription) }
  }

  static var allTests = [("test_SimpleTest", test_SimpleTest)]
}
