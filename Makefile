
# VARIABLES
BASE_HREF = '/flutter-todo-app/'
GITHUB_REPO = git@github.com:Rovaxes/flutter-todo-app.git
BUILD_VERSION := $(shell grep 'version:' pubspec.yaml | awk '{print$$2}')

build-web:
	@echo "Clean Repository"
	flutter clean

	@echo "Get packages"
	flutter pub get

	@echo "Building for web..."
	flutter build web --release --base-href $BASE_HREF

