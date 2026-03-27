import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:saglixen/domain/auth/auth_tokens_model.dart';
import 'package:saglixen/domain/failure/failure.dart';
import 'package:saglixen/infrastructure/auth/auth_client.dart';
import 'package:uuid/uuid.dart';

typedef NetworkRequest<T> = Future<Either<Failure, T>> Function(String accessToken);

mixin AuthMixin {
  FlutterSecureStorage get secureStroge;
  Client get client;
  Uuid get uuid;

  Future<AuthTokens?> _getAccessToken(String refreshToken) async {
    final response = await client.post(
      Uri.parse('http://localhost:8989/v1/auth/refresh'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode({'device_key': await getUniqueDeviceKey(), 'refresh_token': refreshToken}),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      return AuthTokens.fromMap(body);
    }
    return null;
  }

  Future<Either<Failure, T>> sendRequestWithToken<T>(NetworkRequest<T> request) async {
    try {
      var accesToken = await secureStroge.read(key: AuthClient.accessToken);
      final refreshToken = await secureStroge.read(key: AuthClient.refreshTokenKey);

      if (refreshToken == null) {
        return left(UnAuntHorizedfail());
      }

      if (accesToken == null) {
        final newTokens = await _getAccessToken(refreshToken);
        if (newTokens == null) {
          return left(UnAuntHorizedfail());
        }
        final storeResult = await storeAuthTokens(authTokens: newTokens);
        if (storeResult.isLeft()) {
          return left(UnkonwFailure("Token saklanamadı"));
        }
        accesToken = newTokens.accessToken;
      }

      return await request.call(accesToken);
    } catch (e) {
      return left(UnkonwFailure(e.toString()));
    }
  }

  Future<Either<Failure, Unit>> storeAuthTokens({required AuthTokens authTokens}) async {
    try {
      await secureStroge.write(key: AuthClient.accessToken, value: authTokens.accessToken);
      await secureStroge.write(key: AuthClient.refreshTokenKey, value: authTokens.refreshToken);

      return right(unit);
    } catch (e) {
      return left(UnkonwFailure(e.toString()));
    }
  }

  Future<String> getUniqueDeviceKey() async {
    var deviceKey = await secureStroge.read(key: AuthClient.deviceIdKey);
    if (deviceKey == null) {
      deviceKey = uuid.v4();
      await secureStroge.write(key: AuthClient.deviceIdKey, value: deviceKey);
    }
    return deviceKey;
  }
}
