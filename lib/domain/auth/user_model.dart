import 'package:equatable/equatable.dart';
import 'package:saglixen/domain/auth/auth_metod_enum.dart';
import 'package:saglixen/domain/auth/sub_enum.dart';
import 'package:saglixen/domain/auth/sub_model.dart';

class UserModel extends Equatable {
  final String id;
  final String name;
  final String customerId;
  final AuthMethod authMethod;
  final String authId;
  final String? fcmToken;
  final int credits;
  final DateTime? creditsExpiresAt;
  final bool isNewUser;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final SubModel? subscription;

  const UserModel({
    required this.id,
    required this.name,
    required this.customerId,
    required this.authMethod,
    required this.authId,
    required this.credits,
    required this.isNewUser,
    required this.createdAt,
    required this.updatedAt,
    this.fcmToken,
    this.creditsExpiresAt,
    this.deletedAt,
    this.subscription,
  });

  // ─── JSON ───────────────────────────────────────────

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      customerId: json['customer_id'] as String,
      authMethod: AuthMethod.fromKey(json['auth_method'] as String),
      authId: json['auth_id'] as String,
      fcmToken: json['fcm_token'] as String?,
      credits: json['credits'] as int,
      creditsExpiresAt: json['credits_expires_at'] == null
          ? null
          : DateTime.parse(json['credits_expires_at'] as String),
      isNewUser: json['is_new_user'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      deletedAt: json['deleted_at'] == null
          ? null
          : DateTime.parse(json['deleted_at'] as String),
      subscription: json['subscription'] == null
          ? null
          : SubModel.fromJson(
              json['subscription'] as Map<String, dynamic>,
            ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'customer_id': customerId,
      'auth_method': authMethod.key,
      'auth_id': authId,
      'fcm_token': fcmToken,
      'credits': credits,
      'credits_expires_at': creditsExpiresAt?.toIso8601String(),
      'is_new_user': isNewUser,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
      'subscription': subscription?.toJson(),
    };
  }

  // ─── copyWith ───────────────────────────────────────

  UserModel copyWith({
    String? name,
    String? fcmToken,
    int? credits,
    DateTime? creditsExpiresAt,
    bool? isNewUser,
    DateTime? updatedAt,
    DateTime? deletedAt,
    SubModel? subscription,
  }) {
    return UserModel(
      id: id,
      name: name ?? this.name,
      customerId: customerId,
      authMethod: authMethod,
      authId: authId,
      fcmToken: fcmToken ?? this.fcmToken,
      credits: credits ?? this.credits,
      creditsExpiresAt: creditsExpiresAt ?? this.creditsExpiresAt,
      isNewUser: isNewUser ?? this.isNewUser,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      subscription: subscription ?? this.subscription,
    );
  }

  // ─── Helpers ────────────────────────────────────────

  bool get hasActiveSubscription =>
      subscription?.subscriptionStatus == SubscriptionStatus.active;

  bool get isSubscribed => subscription != null;

  // ─── Equatable ──────────────────────────────────────

  @override
  List<Object?> get props => [
    id,
    name,
    customerId,
    authMethod,
    authId,
    fcmToken,
    credits,
    creditsExpiresAt,
    isNewUser,
    createdAt,
    updatedAt,
    deletedAt,
    subscription,
  ];

  @override
  String toString() =>
      'UserModel(id: $id, name: $name, authMethod: ${authMethod.key})';
}
