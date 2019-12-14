import XCTest

import SimulatorControlTests

var tests = [XCTestCaseEntry]()
tests += PlatformLookupTests.allTests()
XCTMain(tests)
