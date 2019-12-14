init:
	git config core.hooksPath .githooks

build:
	swift build

format:
	swift-format -m format --configuration .swift-format -r -i Sources

lint:
	swift-format -m lint --configuration .swift-format -r -i Sources

gitignore-flush:
	git rm -r --cached .
	git add .
	git commit -m ".gitignore flush"

test-swift:
	swift test

test-macos:
	swift package generate-xcodeproj
	set -o pipefail && \
	xcodebuild test \
		-scheme PlatformLookup-Package \
		-destination platform="macOS" \

test-all: test-swift test-macos
