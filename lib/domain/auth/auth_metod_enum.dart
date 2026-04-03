enum AuthMethod {
  email("email"),
  google("google"),
  apple("apple"),
  anonymous("anonymous");

  final String key;
  const AuthMethod(this.key);

  factory AuthMethod.fromKey(String key) {
    return AuthMethod.values.firstWhere(
      (e) => e.key == key,
      orElse: () => throw ArgumentError('Invalid AuthMethod: $key'),
    );
  }
}
