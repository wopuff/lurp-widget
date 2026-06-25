import 'package:lurp/src/config/links.dart';

class User {
  final String uid;

  // public data
  final String username;
  final String flatUsername;
  final String? bio;

  // private data
  final String? rank;
  final String? email;
  final DateTime? createdAt;
  final DateTime? termsAcceptedAt;

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

  // privileges levels
  bool get hasSilenced =>
      ranks.indexOf(rank ?? '') >= ranks.indexOf('silenced');
  bool get hasMember => ranks.indexOf(rank ?? '') >= ranks.indexOf('member');
  bool get hasModerator =>
      ranks.indexOf(rank ?? '') >= ranks.indexOf('moderator');
  bool get hasAdmin => ranks.indexOf(rank ?? '') >= ranks.indexOf('admin');

  bool get isBanned => rank == 'banned';
  bool get isSilenced => rank == 'silenced';
  bool get isMember => rank == 'member';
  bool get isModerator => rank == 'moderator';
  bool get isAdmin => rank == 'admin';

  // routing
  String get path => '/u/$flatUsername';
  String get fullUrl => '${Links.currentBaseUrl}/u/$flatUsername';

  // constants
  static const int minUsernameLength = 4;
  static const int maxUsernameLength = 23;

  static const String unknownUid = '[unknown_uid]';
  static const String unknownUsername = '[unknown_user]';
  static const String defaultRank = 'member';

  static const List<String> ranks = [
    'banned',
    'silenced',
    'member',
    'moderator',
    'admin',
  ];

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

  factory User.unknown() {
    return User(
      uid: unknownUid,
      username: unknownUsername,
      flatUsername: unknownUsername,
      rank: defaultRank,
    );
  }

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

  bool isUnknown() {
    return uid == unknownUid;
  }
}
