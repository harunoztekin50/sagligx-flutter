import 'package:equatable/equatable.dart';

class AuthTokens extends Equatable {
  final String refreshToken;
  final String accessToken;

  const AuthTokens({required this.refreshToken, required this.accessToken});

  factory AuthTokens.fromMap(Map<String, dynamic> json) {
    return AuthTokens(
      refreshToken: json[UserTokens.refreshToken.token] as String,
      accessToken: json[UserTokens.accessToken.token] as String,
    );
  }

  @override
  List<Object?> get props => [accessToken, refreshToken];
}

enum UserTokens {
  accessToken("access_token"),
  refreshToken("refresh_token");

  final String token;

  const UserTokens(this.token);
}
