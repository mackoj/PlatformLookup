init:
	git config core.hooksPath .githooks

build:
	swift build

test-swift:
	swift test

test-macos:
	swift package generate-xcodeproj
	set -o pipefail && \
	xcodebuild test \
		-scheme SimulatorControl-Package \
		-destination platform="macOS" \

test-all: test-swift test-macos
