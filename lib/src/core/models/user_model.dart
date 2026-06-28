import 'package:lurp/src/config/logger.dart';
import 'package:lurp/src/core/entities/common.dart';

class UserModel {
  UserModel({
    required this.uid,
    required this.username,
    required this.flatUsername,
    this.bio,
    this.rank,
    this.email,
    this.createdAt,
    this.termsAcceptedAt,
  });

  factory UserModel.fromData(Map<String, dynamic> data) {
    try {
      return UserModel(
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
      logger.e('UserModel: Error converting from data: $e');
      return UserModel.unknown();
    }
  }

  factory UserModel.unknown() {
    return UserModel(
      uid: User.unknownUid,
      username: User.unknownUsername,
      flatUsername: User.unknownUsername,
      rank: User.defaultRank,
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

  User toEntity() {
    final bio = (this.bio?.trim().isEmpty ?? true) ? null : this.bio?.trim();

    return User(
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
