.PHONY: help clean format lint test publish-dry publish

help: ## Show this help
	@echo "Available commands:"
	@echo "  make clean    - Clean project"
	@echo "  make lint     - Run analyzer"
	@echo "  make test     - Run tests"
	@echo "  make publish  - Publish to pub.dev"

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
