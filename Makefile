# Generate a random number.
# This is not run initially.
GENERATE_ID = $(shell od -vAn -N2 -tu2 < /dev/urandom)

# Generate a random number, and assign it to MY_ID
# This is not run initially.
SET_ID = $(eval MY_ID=$(GENERATE_ID))


PLATFORM_IOS = iOS Simulator,name=iPhone 11 Pro Max,OS=13.4.1
PLATFORM_MACOS = macOS
PLATFORM_TVOS = tvOS Simulator,name=Apple TV 4K (at 1080p),OS=13.4

init:
	git config core.hooksPath .githooks
	
default: test-all

test-all: test-swift test-macos

test-macos:
	swift package generate-xcodeproj
	set -o pipefail && \
	xcodebuild test \
		-scheme PlatformLookup-Package \
		-destination platform="macOS" \

test-swift:
	swift test \
		--enable-pubgrub-resolver \
		--enable-test-discovery \
		--parallel
		
generate-enum-properties:
	generate-enum-properties Sources/**/*.swift

gitignore-flush:
	git rm -r --cached .
	git add .
	git commit -m ".gitignore flush"

install-generate-enum-properties:
	echo "Installing swift-enum-properties"
	git clone https://github.com/pointfreeco/swift-enum-properties.git /tmp/__hawkci__/swift-enum-properties
	cd /tmp/__hawkci__/swift-enum-properties
	make install

format:
	swift format --in-place --recursive .

.PHONY: format

