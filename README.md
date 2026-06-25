# Lurp Widgets

A Flutter package to display interactive, read-only polls and thought posts integrated with the Lurp ecosystem.

## Features

- **Read-Only Selection Polls**: Display poll options with pre-calculated vote counts and percentage layouts.
- **Slider Polls**: Display a sliding scale with average ratings and standard deviation markers.
- **Rating Polls**: Pixel-perfect star-clipped ratings showing precise average ratings.
- **Thought Posts**: Clean text layout blocks for displaying content or comments.
- **API Integrated Loader**: Easy fetching and presentation using the `LurpPostWidget`.

## Getting started

Add the dependency to your `pubspec.yaml`:

```yaml
dependencies:
  lurp: ^0.0.1
```

## Usage

### 1. Initialize Configuration

Before rendering any widgets, initialize Lurp with your API key:

```dart
import 'package:lurp/lurp.dart';

void main() {
  Lurp.initialize(
    apiKey: 'your-api-key-here',
    isProd: true, // Set to false to use the staging/development environment
  );
  runApp(const MyApp());
}
```

### 2. Display a Poll / Post Widget

Embed `LurpPostWidget` anywhere in your tree to load and display a post by its ID:

```dart
import 'package:flutter/material.dart';
import 'package:lurp/lurp.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Poll Stats')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: LurpPostWidget(
            postId: 'your-post-id',
            onCreatorTap: (creator) {
              print('Tapped creator: ${creator.username}');
            },
            onShareTap: (post) {
              print('Sharing post: ${post.fullUrl}');
            },
          ),
        ),
      ),
    );
  }
}
```

## Additional information

For more information, visit the homepage at [lurp.it](https://www.lurp.it/en).
