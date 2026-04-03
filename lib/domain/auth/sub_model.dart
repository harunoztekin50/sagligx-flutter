import 'package:equatable/equatable.dart';
import 'package:saglixen/domain/auth/sub_enum.dart';

class SubModel extends Equatable {
  final SubscriptionPlan? subscriptionPlan;
  final SubscriptionPeriod? subscriptionPeriod;
  final SubscriptionType? subscriptionType;
  final SubscriptionStatus? subscriptionStatus;
  final DateTime? subscriptionExpiresAt;

  const SubModel({
    this.subscriptionPlan,
    this.subscriptionPeriod,
    this.subscriptionType,
    this.subscriptionStatus,
    this.subscriptionExpiresAt,
  });

  // ─── JSON ───────────────────────────────────────────

  factory SubModel.fromJson(Map<String, dynamic> json) {
    return SubModel(
      subscriptionPlan: json['subscription_plan'] == null
          ? null
          : SubscriptionPlan.fromKey(
              json['subscription_plan'] as String,
            ),
      subscriptionPeriod: json['subscription_period'] == null
          ? null
          : SubscriptionPeriod.fromKey(
              json['subscription_period'] as String,
            ),
      subscriptionType: json['subscription_type'] == null
          ? null
          : SubscriptionType.fromKey(
              json['subscription_type'] as String,
            ),
      subscriptionStatus: json['subscription_status'] == null
          ? null
          : SubscriptionStatus.fromKey(
              json['subscription_status'] as String,
            ),
      subscriptionExpiresAt: json['subscription_expires_at'] == null
          ? null
          : DateTime.parse(json['subscription_expires_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subscription_plan': subscriptionPlan?.key,
      'subscription_period': subscriptionPeriod?.key,
      'subscription_type': subscriptionType?.key,
      'subscription_status': subscriptionStatus?.key,
      'subscription_expires_at': subscriptionExpiresAt
          ?.toIso8601String(),
    };
  }

  // ─── copyWith ───────────────────────────────────────

  SubModel copyWith({
    SubscriptionPlan? subscriptionPlan,
    SubscriptionPeriod? subscriptionPeriod,
    SubscriptionType? subscriptionType,
    SubscriptionStatus? subscriptionStatus,
    DateTime? subscriptionExpiresAt,
  }) {
    return SubModel(
      subscriptionPlan: subscriptionPlan ?? this.subscriptionPlan,
      subscriptionPeriod:
          subscriptionPeriod ?? this.subscriptionPeriod,
      subscriptionType: subscriptionType ?? this.subscriptionType,
      subscriptionStatus:
          subscriptionStatus ?? this.subscriptionStatus,
      subscriptionExpiresAt:
          subscriptionExpiresAt ?? this.subscriptionExpiresAt,
    );
  }

  // ─── Equatable ──────────────────────────────────────

  @override
  List<Object?> get props => [
    subscriptionPlan,
    subscriptionPeriod,
    subscriptionType,
    subscriptionStatus,
    subscriptionExpiresAt,
  ];

  // ─── Debug ──────────────────────────────────────────

  @override
  String toString() {
    return 'SubModel('
        'plan: ${subscriptionPlan?.key}, '
        'period: ${subscriptionPeriod?.key}, '
        'type: ${subscriptionType?.key}, '
        'status: ${subscriptionStatus?.key}, '
        'expiresAt: $subscriptionExpiresAt'
        ')';
  }
}
