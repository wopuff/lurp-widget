import 'package:lurp/src/config/links.dart';

/// Represents a user within the Lurp system.
class User {
  /// Creates a new [User] instance.
  User({
    required this.uid,
    required this.username,
    required this.flatUsername,
    this.bio,
    this.rank,
    this.email,
    this.createdAt,
    this.termsAcceptedAt,
  });

  /// Factory constructor to create an empty [User] template with optional parameter overrides.
  factory User.fromEmpty({
    String? uid,
    String? username,
    String? flatUsername,
    String? email,
    DateTime? createdAt,
    DateTime? termsUpdatedAt,
    String? rank,
  }) {
    return User(
      uid: uid ?? '',
      username: username ?? '',
      flatUsername: flatUsername ?? '',
      email: email,
      createdAt: createdAt,
      termsAcceptedAt: termsUpdatedAt,
      rank: rank,
    );
  }

  /// Factory constructor to create an unknown placeholder user.
  factory User.unknown() {
    return User(
      uid: unknownUid,
      username: unknownUsername,
      flatUsername: unknownUsername,
      rank: defaultRank,
    );
  }

  /// The unique identifier of the user.
  final String uid;

  /// The user's public display name.
  final String username;

  /// A simplified, lowercased version of the username used for URLs and routing.
  final String flatUsername;

  /// The user's biography or profile text, if any.
  final String? bio;

  /// The user's rank/privilege level.
  final String? rank;

  /// The user's email address.
  final String? email;

  /// The date and time when this user account was created.
  final DateTime? createdAt;

  /// The date and time when this user accepted the platform's terms of service.
  final DateTime? termsAcceptedAt;

  /// Whether the user has at least silenced rank privileges.
  bool get hasSilenced =>
      ranks.indexOf(rank ?? '') >= ranks.indexOf('silenced');

  /// Whether the user has at least standard member privileges.
  bool get hasMember => ranks.indexOf(rank ?? '') >= ranks.indexOf('member');

  /// Whether the user has at least moderator privileges.
  bool get hasModerator =>
      ranks.indexOf(rank ?? '') >= ranks.indexOf('moderator');

  /// Whether the user has administrative privileges.
  bool get hasAdmin => ranks.indexOf(rank ?? '') >= ranks.indexOf('admin');

  /// Whether the user is currently banned.
  bool get isBanned => rank == 'banned';

  /// Whether the user is currently silenced.
  bool get isSilenced => rank == 'silenced';

  /// Whether the user is a standard member.
  bool get isMember => rank == 'member';

  /// Whether the user is a moderator.
  bool get isModerator => rank == 'moderator';

  /// Whether the user is an admin.
  bool get isAdmin => rank == 'admin';

  /// The relative URL route path for the user's profile page.
  String get path => '/u/$flatUsername';

  /// The absolute URL for the user's profile page.
  String get fullUrl => '${Links.currentBaseUrl}/u/$flatUsername';

  /// The minimum length required for a username.
  static const int minUsernameLength = 4;

  /// The maximum length allowed for a username.
  static const int maxUsernameLength = 23;

  /// The default placeholder UID used for unknown or deleted users.
  static const String unknownUid = '[unknown_uid]';

  /// The default placeholder username used for unknown or deleted users.
  static const String unknownUsername = '[unknown_user]';

  /// The default rank assigned to new users.
  static const String defaultRank = 'member';

  /// The list of all available user privilege ranks, ordered from lowest to highest.
  static const List<String> ranks = [
    'banned',
    'silenced',
    'member',
    'moderator',
    'admin',
  ];

  /// Creates a copy of this user with the given fields replaced by new values.
  User copyWith({
    String? uid,
    String? username,
    String? flatUsername,
    String? rank,
    String? email,
    DateTime? createdAt,
    DateTime? termsUpdatedAt,
  }) {
    return User(
      uid: uid ?? this.uid,
      username: username ?? this.username,
      flatUsername: flatUsername ?? this.flatUsername,
      rank: rank ?? this.rank,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
      termsAcceptedAt: termsUpdatedAt ?? termsAcceptedAt,
    );
  }

  /// Returns true if this user represents an unknown or deleted user.
  bool isUnknown() {
    return uid == unknownUid;
  }
}
