enum SubscriptionType {
  normal('normal'),
  trial('trial'),
  intro('intro'),
  prepaid('prepaid'),
  promo('promo')
  ;

  final String key;
  const SubscriptionType(this.key);

  factory SubscriptionType.fromKey(String key) {
    return SubscriptionType.values.firstWhere(
      (e) => e.key == key,
      orElse: () =>
          throw ArgumentError('Invalid SubscriptionType: $key'),
    );
  }
}

enum SubscriptionStatus {
  active('active'),
  expired('expired'),
  billingIssue('billing_issue')
  ;

  final String key;
  const SubscriptionStatus(this.key);

  factory SubscriptionStatus.fromKey(String key) {
    return SubscriptionStatus.values.firstWhere(
      (e) => e.key == key,
      orElse: () =>
          throw ArgumentError('Invalid SubscriptionStatus: $key'),
    );
  }
}

enum SubscriptionPlan {
  pro('pro')
  ;

  final String key;
  const SubscriptionPlan(this.key);

  factory SubscriptionPlan.fromKey(String key) {
    return SubscriptionPlan.values.firstWhere(
      (e) => e.key == key,
      orElse: () =>
          throw ArgumentError('Invalid SubscriptionPlan: $key'),
    );
  }
}

enum SubscriptionPeriod {
  oneWeek('1w', 7),
  oneMonth('1m', 30),
  sixMonth('6m', 180),
  oneYear('1y', 365)
  ;

  final String key;
  final int days;
  const SubscriptionPeriod(this.key, this.days);

  factory SubscriptionPeriod.fromKey(String key) {
    return SubscriptionPeriod.values.firstWhere(
      (e) => e.key == key,
      orElse: () =>
          throw ArgumentError('Invalid SubscriptionPeriod: $key'),
    );
  }
}

extension SubscriptionPeriodX on SubscriptionPeriod {
  String get toLabelInfo => switch (this) {
    SubscriptionPeriod.oneWeek => SubscriptionLabels.oneWeek,
    SubscriptionPeriod.oneMonth => SubscriptionLabels.oneMonth,
    SubscriptionPeriod.sixMonth => SubscriptionLabels.sixMonth,
    SubscriptionPeriod.oneYear => SubscriptionLabels.oneYear,
  };
}

abstract class SubscriptionLabels {
  static const String oneWeek = '1 Hafta';
  static const String oneMonth = '1 Ay';
  static const String sixMonth = '6 Ay';
  static const String oneYear = '1 Yıl';
}
