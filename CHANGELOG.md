## 0.0.4
* **Fixed:** Corrected `SocketException` handling for non-Web platforms by introducing platform-specific implementations for connection error detection.
* **Refactored:** Updated `ApiClient` to use platform-specific connection error checking instead of direct `dart:io` imports.
* **Maintenance:** Addressed `deprecated_member_use` lint for `cacheExtent` in `CommentsSectionContent`.

## 0.0.3
* **Fixed:** Configured `pubspec.yaml` settings to optimize pub points and fixed Dart `const` warning/lint errors.
* **Refactored:** Performed internal code refactoring across the codebase without changing external APIs or functionality.

## 0.0.2
* **Fixed:** Resolved `DioException` error by updating `dio` dependency constraint.
* **Added:** Full platform support declarations in `pubspec.yaml`.
* **Improved:** Added Dartdoc comments (`///`) to improve API readability.

## 0.0.1
* Initial release of the `lurp` package.
* Added `LurpPostWidget` to display polls and thought posts by ID.
* Standardized selection, slider, rating, and thought post components as read-only standard Flutter widgets.
