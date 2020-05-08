init:
	git config core.hooksPath .githooks

build:
	swift build

format:
	swift-format -m format --configuration .swift-format -r -i Sources/**/*.swift
	swift-format -m format --configuration .swift-format -r -i Tests/**/*.swift
#
# lint:
# 	swift-format -m lint --configuration .swift-format -r -i Sources/**/*.swift
# 	swift-format -m lint --configuration .swift-format -r -i Tests/**/*.swift

generate-enum-properties:
	generate-enum-properties Sources/**/*.swift

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

install-swift-format:
	rm -rf /tmp/__hawkci__/swift-format
	rm -f /usr/local/bin/swift-format
	rm -f /usr/local/bin/generate-pipeline
	git clone --single-branch --branch swift-5.1-branch https://github.com/apple/swift-format.git /tmp/__hawkci__/swift-format
	cd /tmp/__hawkci__/swift-format
	swift build -c release
	cp /tmp/__hawkci__/swift-format/.build/release/swift-format /usr/local/bin/swift-format
	cp /tmp/__hawkci__/swift-format/.build/release/generate-pipeline /usr/local/bin/generate-pipeline

install-generate-enum-properties:
	echo "Installing swift-enum-properties"
	git clone https://github.com/pointfreeco/swift-enum-properties.git /tmp/__hawkci__/swift-enum-properties
	cd /tmp/__hawkci__/swift-enum-properties
	make install

test: test-swift test-macos
