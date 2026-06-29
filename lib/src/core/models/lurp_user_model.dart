import 'package:lurp/src/config/logger.dart';
import 'package:lurp/src/core/entities/common.dart';

class LurpUserModel {
  LurpUserModel({
    required this.uid,
    required this.username,
    required this.flatUsername,
    this.bio,
    this.rank,
    this.email,
    this.createdAt,
    this.termsAcceptedAt,
  });

  factory LurpUserModel.fromData(Map<String, dynamic> data) {
    try {
      return LurpUserModel(
        uid: data['id'],
        username: data['username'],
        flatUsername: data['flatUsername'],
        bio: data['bio'],
        rank: data['rank'],
        email: data['email'],
        createdAt: data['createdAt'] != null
            ? DateTime.parse(data['createdAt'])
            : null,
        termsAcceptedAt: data['termsAcceptedAt'] != null
            ? DateTime.parse(data['termsAcceptedAt'])
            : null,
      );
    } catch (e) {
      logger.e('LurpUserModel: Error converting from data: $e');
      return LurpUserModel.unknown();
    }
  }

  factory LurpUserModel.unknown() {
    return LurpUserModel(
      uid: LurpUser.unknownUid,
      username: LurpUser.unknownUsername,
      flatUsername: LurpUser.unknownUsername,
      rank: LurpUser.defaultRank,
    );
  }
  // public data
  final String uid;
  final String username;
  final String flatUsername;
  final String? bio;

  // private data
  final String? rank;
  final String? email;
  final DateTime? createdAt;
  final DateTime? termsAcceptedAt;

  LurpUser toEntity() {
    final bio = (this.bio?.trim().isEmpty ?? true) ? null : this.bio?.trim();

    return LurpUser(
      uid: uid,
      username: username,
      flatUsername: flatUsername,
      bio: bio,
      email: email,
      createdAt: createdAt,
      rank: rank,
      termsAcceptedAt: termsAcceptedAt,
    );
  }
}
