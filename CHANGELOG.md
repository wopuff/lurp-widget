## 0.2.0
* **Breaking Change:** Swapped the primary `Lurp` widget constructors: the default unnamed `Lurp(...)` constructor now fetches posts dynamically from the network via `postId`, and `Lurp.local(...)` renders pre-loaded local models.
* **Breaking Change:** Removed all development environment API parameters (`isProd` and the `dev.api.lurp.it` configuration) to route all network traffic directly to the production endpoint.
* **Feature:** Made the `apiKey` parameter optional in `Lurp.initialize(...)`. When provided, it is securely transmitted using a custom `Lurp-Access-Token` request header.
* **Refactor:** Reorganized the internal directory structure to follow Clean Architecture principles, grouping code under `src/core/`, `src/domain/`, `src/data/`, and `src/presentation/`.

## 0.1.0
* **Breaking Change (Namespacing Refactor):** Prefixed generic public classes and files with `Lurp` (e.g., `User` -> `LurpUser`, `Post` -> `LurpPost`, `Comment` -> `LurpComment`, `PostRepository` -> `LurpPostRepository`) to prevent namespace collisions when implementing the package in host applications.
* **Feature:** Upgraded `RatingWidget` to support custom layered SVG stars and animated wipe reveals utilizing `StarArtworkClipper` (with 0.55 visible ratio) and `IconAsset`.
* **Feature:** Added interactive state support to `RatingWidget` via self-contained StatefulWidget logic that triggers rating animations on click.
* **Dependency:** Added `flutter_svg` to `pubspec.yaml` to enable vector graphics support.
* **Testing:** Fixed the example app's test suite to use the updated class structure and verified everything with passing tests.

## 0.0.5
* **Refactored:** Replaced external `logger` package dependency with a lightweight, custom `LurpLogger` using `dart:developer` and `print` for Web support.
* **Dependency Update:** Upgraded `dio` constraint to `^5.6.0`.
* **Maintenance:** Cleaned up unused comments and updated description in `example/pubspec.yaml`.

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
