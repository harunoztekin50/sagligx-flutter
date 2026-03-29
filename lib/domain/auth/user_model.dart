import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id; // uuid → String olarak tutuyoruz
  final String name;
  final String customerId;
  final String authMethod;
  final String authId;
  final String? fcmToken; // NULL olabilir → nullable
  final int credits; // bigint → int (Dart'ta 64-bit zaten)
  final DateTime? creditsExpiresAt;
  final String? subscriptionPlan;
  final String? subscriptionPeriod;
  final String? subscriptionType;
  final String? subscriptionStatus;
  final DateTime? subscriptionExpiresAt;
  final bool isNewUser;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt; // soft delete → nullable

  const UserModel({
    required this.id,
    required this.name,
    required this.customerId,
    required this.authMethod,
    required this.authId,
    this.fcmToken,
    required this.credits,
    this.creditsExpiresAt,
    this.subscriptionPlan,
    this.subscriptionPeriod,
    this.subscriptionType,
    this.subscriptionStatus,
    this.subscriptionExpiresAt,
    required this.isNewUser,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  // ─── JSON'dan Model oluşturma (API response → Dart objesi) ───
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      customerId: json['customer_id'] as String,
      authMethod: json['auth_method'] as String,
      authId: json['auth_id'] as String,
      fcmToken: json['fcm_token'] as String?,
      credits: json['credits'] as int,
      creditsExpiresAt: json['credits_expires_at'] != null
          ? DateTime.parse(json['credits_expires_at'] as String)
          : null,
      subscriptionPlan: json['subscription_plan'] as String?,
      subscriptionPeriod: json['subscription_period'] as String?,
      subscriptionType: json['subscription_type'] as String?,
      subscriptionStatus: json['subscription_status'] as String?,
      subscriptionExpiresAt: json['subscription_expires_at'] != null
          ? DateTime.parse(json['subscription_expires_at'] as String)
          : null,
      isNewUser: json['is_new_user'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'] as String)
          : null,
    );
  }

  // ─── Model'den JSON oluşturma (Dart objesi → API request body) ───
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'customer_id': customerId,
      'auth_method': authMethod,
      'auth_id': authId,
      'fcm_token': fcmToken,
      'credits': credits,
      'credits_expires_at': creditsExpiresAt?.toIso8601String(),
      'subscription_plan': subscriptionPlan,
      'subscription_period': subscriptionPeriod,
      'subscription_type': subscriptionType,
      'subscription_status': subscriptionStatus,
      'subscription_expires_at': subscriptionExpiresAt
          ?.toIso8601String(),
      'is_new_user': isNewUser,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
    };
  }

  // ─── copyWith: immutable update pattern ───
  UserModel copyWith({
    String? name,
    String? fcmToken,
    int? credits,
    DateTime? creditsExpiresAt,
    String? subscriptionPlan,
    String? subscriptionPeriod,
    String? subscriptionType,
    String? subscriptionStatus,
    DateTime? subscriptionExpiresAt,
    bool? isNewUser,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) {
    return UserModel(
      id: id, // değişmez
      name: name ?? this.name,
      customerId: customerId, // değişmez
      authMethod: authMethod, // değişmez
      authId: authId, // değişmez
      fcmToken: fcmToken ?? this.fcmToken,
      credits: credits ?? this.credits,
      creditsExpiresAt: creditsExpiresAt ?? this.creditsExpiresAt,
      subscriptionPlan: subscriptionPlan ?? this.subscriptionPlan,
      subscriptionPeriod:
          subscriptionPeriod ?? this.subscriptionPeriod,
      subscriptionType: subscriptionType ?? this.subscriptionType,
      subscriptionStatus:
          subscriptionStatus ?? this.subscriptionStatus,
      subscriptionExpiresAt:
          subscriptionExpiresAt ?? this.subscriptionExpiresAt,
      isNewUser: isNewUser ?? this.isNewUser,
      createdAt: createdAt, // değişmez
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  @override
  String toString() =>
      'UserModel(id: $id, name: $name, authMethod: $authMethod)';

  @override
  List<Object?> get props => [id, customerId, authId];
}
