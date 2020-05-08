init:
	git config core.hooksPath .githooks
	
default: test-all

test: test-swift test-macos

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
	swift format --in-place --configuration .swift-format --recursive .

.PHONY: format
	$(eval PLATFORM_IOS = $(shell swift run cli "iphone se"))
	$(eval PLATFORM_TVOS = $(shell swift run cli "Apple TV 4K"))
