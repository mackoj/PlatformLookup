init:
	git config core.hooksPath .githooks

xcodeproj:
	swift run xcodegen

build:
	swift build

test-swift:
	swift test

test-macos:
	set -o pipefail && \
	xcodebuild test \
		-scheme SnapshotTesting_macOS \
		-destination platform="macOS" \

test-all: test-swift test-macos
