/// Represents a simple text post (thought) within the system.
class ThoughtPost {
  /// Creates a new [ThoughtPost] instance with the specified [text].
  ThoughtPost({required this.text});

  /// The main text content of the thought post.
  final String text;

  /// The minimum length required for a thought post's text content.
  static const int minTextLength = 11;

  /// The maximum length allowed for a thought post's text content.
  static const int maxTextLength = 1999;
}
