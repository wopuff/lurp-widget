/// Represents a media asset (e.g. image, video) attached to a post.
class MediaEntity {
  /// Creates a new [MediaEntity] instance.
  MediaEntity({required this.key, required this.url, this.sortOrder});

  /// The unique key identifying the media asset.
  final String key;

  /// The URL path to load the media resource.
  final String url;

  /// The sorting order of this media item inside a gallery.
  final int? sortOrder;
}
