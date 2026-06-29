.PHONY: help clean format lint test publish-dry publish run run-web run-windows run-android run-ios run-macos run-linux

help: ## Show this help
	@echo "Available commands:"
	@echo "  make clean        - Clean project"
	@echo "  make lint         - Run analyzer"
	@echo "  make test         - Run tests"
	@echo "  make publish      - Publish to pub.dev"
	@echo "  make run          - Run the example app (interactive device selection)"
	@echo "  make run-web      - Run the example app on Web (Chrome)"
	@echo "  make run-windows  - Run the example app on Windows"
	@echo "  make run-android  - Run the example app on Android"
	@echo "  make run-ios      - Run the example app on iOS"
	@echo "  make run-macos    - Run the example app on macOS"
	@echo "  make run-linux    - Run the example app on Linux"

clean: ## Clean the project build cache
	@echo "Cleaning project..."
	@flutter clean
	@flutter pub get

format: ## Format the code
	@echo "Formatting code..."
	@dart format lib/

lint: ## Run static analysis
	@echo "Running linting..."
	@dart analyze .

test: ## Run unit tests
	@echo "Running tests..."
	@flutter test

publish-dry: clean lint test ## Clean, lint, test, and dry-run publish
	@echo "Dry run publish..."
	@flutter pub publish --dry-run

publish: publish-dry ## Clean, lint, test, and publish to pub.dev
	@echo "Publishing to pub.dev..."
	@flutter pub publish

run: ## Run the example app (interactive device selection)
	@echo "Running example app..."
	@cd example && flutter run

run-web: ## Run the example app on Web (Chrome)
	@echo "Running example app on Web..."
	@cd example && flutter run -d chrome

run-windows: ## Run the example app on Windows
	@echo "Running example app on Windows..."
	@cd example && flutter run -d windows

run-android: ## Run the example app on Android
	@echo "Running example app on Android..."
	@cd example && flutter run -d android

run-ios: ## Run the example app on iOS
	@echo "Running example app on iOS..."
	@cd example && flutter run -d ios

run-macos: ## Run the example app on macOS
	@echo "Running example app on macOS..."
	@cd example && flutter run -d macos

run-linux: ## Run the example app on Linux
	@echo "Running example app on Linux..."
	@cd example && flutter run -d linux

