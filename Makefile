#
# Makefile for CI/CD Environments and commandline users
#
-include .env
FLAVOR=int

# Run app
run:
	flutter run --web-port 55130 --web-browser-flag "--disable-web-security"

run-release:
	flutter run --release

# Download .env-config
config:
	@echo "Fetching .env file from 1Password..."
	touch .env
	op document get hgqy56xemj3yxcvi2t6cd3lfcy > .env
	@echo "Done"

config-prod:
	@echo "Fetching .env file from 1Password..."
	touch .env
	op document get if3lye45sta6vpaek6mdimfqha > .env
	@echo "Done"

# Format & Lint
clean:
	flutter clean
	flutter pub get
	make build-runner
	make format
format:
	dart format . --line-length 120
format-check:
	dart format . --line-length 120 --set-exit-if-changed
lint:
	flutter analyze --no-pub

# Testing
test:
	flutter test --coverage -r expanded
.PHONY: test
test-ci:
	flutter test --machine --coverage -r expanded --file-reporter "json:tests.json" | tojunit --output report.xml
	genhtml coverage/lcov.info --output=coverage

# Testing with maestro
# you have to be in the project folder
test-maestro:
	maestro test test/maestro/FlowStart.yaml

# Build runner
build-runner:
	dart run build_runner build --delete-conflicting-outputs
build-runner-watch:
	dart run build_runner watch --delete-conflicting-outputs

# Additional helpers
packages-outdated:
	flutter pub outdated
packages-upgrade:
	flutter pub upgrade
l10n:
	flutter gen-l10n
appicon:
	flutter pub run flutter_launcher_icons -f flutter_launcher_icons.yaml
splashscreen:
	flutter pub run flutter_native_splash:create --path=flutter_native_splash.yaml

# Export Archives .ipa, .aab, .apk and web
# build web
build-web:
	@echo "Building Web ..."
	make clean
	mkdir -p dist
	rm -rf dist/web
	flutter build web --release
	cp -r build/web dist/web
release-web:
	@echo "Release Web"
	vercel build
	vercel deploy --prebuilt

# build .apk
build-apk:
	@echo "Building Android .apk ..."
	rm -rf dist/meteosol-release.apk
	make clean
	flutter build apk --target-platform=android-arm,android-arm64 --obfuscate --split-debug-info=./dist/debug/
	cp build/app/outputs/apk/release/app-release.apk dist/meteosol-release.apk
build-appbundle:
	@echo "Building Android .aab ..."
	rm -rf dist/meteosol-release.aab
	rm -rf ./crashlytics
	rm -rf ./dist/debug
	make clean
	flutter build appbundle --obfuscate --split-debug-info=./dist/debug/
	cp build/app/outputs/bundle/release/app-release.aab dist/meteosol-release.aab
# build .ipa
build-ipa:
	@echo "Building Apple iOS ..."
	rm -rf dist/meteosol-release.ipa
	rm -rf ./crashlytics
	rm -rf ./dist/debug
	make clean
	rm -rf ios/dist
	flutter build ipa --obfuscate --split-debug-info=./dist/debug/ --export-options-plist=ios/ios-export-options.plist --suppress-analytics
	cp build/ios/ipa/meteosol.ipa dist/meteosol-release.ipa

# Release prod
release:
	make config-prod
	make build-ipa
	./dsyms.sh
	make build-appbundle
	./firebase_symbols.sh
	echo 'Reset to dev config'
	make config