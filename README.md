# Lurp Widgets

[![pub package](https://img.shields.io/pub/v/lurp.svg)](https://pub.dev/packages/lurp)
[![pub points](https://img.shields.io/pub/points/lurp.svg)](https://pub.dev/packages/lurp)

A premium, lightweight, and dependency-trimmed Flutter package to embed interactive, read-only stats for polls, posts, and comments directly from the Lurp ecosystem into your Flutter apps.

---

## Features

- **Offline & Online Rendering**: Fetch posts automatically using the Lurp backend or feed your own `Post` models manually.
- **Visual Poll Types**:
  - **Selection Poll**: Shows options with proportional bar graphs representing vote distributions.
  - **Slider Poll**: Represents ratings on a sliding scale with average results and standard deviation indicators.
  - **Rating Poll**: Renders star ratings with pixel-perfect custom clipped layout for fractional stars.
  - **Thought Post**: Render general text posts/thoughts and announcements.
- **Embedded Comments**: Integrated comments section loader support with cursor-based pagination out of the box.
- **Completely Customizable**: Adheres to your app's existing `ThemeData` (background colors, fonts, card styles, and buttons).

---

## Getting Started

Add `lurp` to your `pubspec.yaml`:

```yaml
dependencies:
  lurp: ^0.0.1
```

Then run:
```bash
flutter pub get
```

---

## Usage

### 1. Initialize Configuration

Call `Lurp.initialize` before launching your app (e.g., in `main()`) to register your API key and set the target environment:

```dart
import 'package:flutter/material.dart';
import 'package:lurp/lurp.dart';

void main() {
  // Setup Lurp package configurations
  Lurp.initialize(
    apiKey: 'YOUR_LURP_API_KEY',
    isProd: true, // Use false to connect to dev.api.lurp.it instead of the production API
  );
  runApp(const MyApp());
}
```

### 2. High-Level Integration (LurpPostWidget)

To display a poll or post dynamically from the Lurp API, use `LurpPostWidget`. It handles request states, loading animations, error fallbacks, and content fetching internally:

```dart
import 'package:flutter/material.dart';
import 'package:lurp/lurp.dart';

class PollDetailsPage extends StatelessWidget {
  final String postId;

  const PollDetailsPage({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Poll Stats')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: LurpPostWidget(
            postId: postId,
            onCreatorTap: (creator) {
              // Custom navigation or action when the creator's avatar/username is tapped
              print('Tapped creator: ${creator.username}');
            },
            onShareTap: (post) {
              // Custom share handler (e.g. copy link, trigger system share sheet)
              print('Sharing post: ${post.fullUrl}');
            },
          ),
        ),
      ),
    );
  }
}
```

### 3. Lower-Level Custom Rendering (PostWidget)

If you are caching data locally or constructing mock/custom content, you can bypass the backend and pass a `Post` model directly into `PostWidget`:

```dart
import 'package:flutter/material.dart';
import 'package:lurp/lurp.dart';

Widget buildCustomMockPoll() {
  final mockCreator = User(
    uid: 'user-123',
    username: 'LurpDeveloper',
    flatUsername: 'lurpdeveloper',
    rank: 'Pro Creator',
  );

  final mockPost = Post(
    id: 'mock-poll-id',
    type: 'selection',
    state: 'visible',
    createdAt: DateTime.now(),
    commentCount: 42,
    upvoteCount: 156,
    downvoteCount: 3,
    creator: mockCreator,
    topComments: [],
    media: [],
    siuRating: '',
    selection: SelectionPoll(
      title: 'What is your favorite Flutter state management solution?',
      options: [
        PollOption(key: 'bloc', text: 'Bloc', voteCount: 450),
        PollOption(key: 'riverpod', text: 'Riverpod', voteCount: 510),
        PollOption(key: 'provider', text: 'Provider', voteCount: 220),
      ],
      siuVote: null,
      voteCount: 1180,
    ),
  );

  return PostWidget(
    post: mockPost,
    onCreatorTap: (creator) => print('Clicked ${creator.username}'),
    onShareTap: (post) => print('Share clicked'),
  );
}
```

---

## Previewing and Testing

An interactive demo showing all poll styles (Selection, Slider, Rating, and Thought) is available in the [example](example) directory.

To run it on Web:
```bash
cd example
flutter run -d chrome
```

To run it on Windows:
```bash
cd example
flutter run -d windows
```

---

## Additional Information

- **Filing Issues**: Report bugs or feature requests on the [GitHub Issue Tracker](https://github.com/wopuff/lurp-widget/issues).
- **Contributing**: Contributions are welcome! Feel free to open a Pull Request.
- **License**: Released under the [BSD 3-Clause License](LICENSE).
