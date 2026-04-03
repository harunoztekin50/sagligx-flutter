import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:saglixen/core/failure/failure.dart';
import 'package:saglixen/domain/auth/auth_tokens_model.dart';
import 'package:uuid/uuid.dart';

typedef NetworkRequest<T> =
    Future<Response> Function(String accessToken);
typedef ResponseCallBack<T> =
    Future<Either<Failure, T>> Function(Response r);
typedef ExeptionCallBack<T> =
    Future<Either<Failure, T>> Function(Object e);

mixin AuthMixin {
  FlutterSecureStorage get secureStroge;
  Client get client;
  Uuid get uuid;

  static const deviceIdKey = "device_id";
  static const refreshTokenKey = "refresh_token";
  static const accessTokenKey = "access_token";

  Future<AuthTokens?> _getAccessToken(String refreshToken) async {
    final response = await client.post(
      Uri.parse('http://10.0.2.2:8989/v1/auth/refresh'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode({
        'device_key': await getUniqueDeviceKey(),
        'refresh_token': refreshToken,
      }),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      return AuthTokens.fromMap(body);
    }
    return null;
  }

  bool _isTokenExpired(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return true;

      // JWT'nin payload kısmı (ortadaki parça)
      final normalized = base64Url.normalize(parts[1]);
      final payload = json.decode(
        utf8.decode(base64Url.decode(normalized)),
      );

      final exp = payload['exp'] as int?;
      if (exp == null) return true;

      // 30 saniye buffer — tam sınırda gönderip yolda expire olmasın
      final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      return now >= exp - 30;
    } catch (_) {
      return true; // parse edilemiyorsa expired say, yenilensin
    }
  }

  Future<Either<Failure, T>> sendRequestWithToken<T>(
    NetworkRequest request,
    ResponseCallBack<T> onResponse,
    ExeptionCallBack<T> exepciton,
  ) async {
    try {
      var accesToken = await secureStroge.read(key: accessTokenKey);
      var refreshToken = await secureStroge.read(
        key: refreshTokenKey,
      );

      if (refreshToken == null || accesToken == null) {
        return left(UnAuntHorizedfail());
      }

      if (_isTokenExpired(accesToken)) {
        final newTokens = await _getAccessToken(refreshToken);
        if (newTokens == null) {
          return left(UnAuntHorizedfail());
        }
        final storeResult = await storeAuthTokens(
          authTokens: newTokens,
        );
        if (storeResult.isLeft()) {
          return left(UnkonwFailure("Token saklanamadı"));
        }
        accesToken = newTokens.accessToken;
        refreshToken = newTokens.refreshToken;
      }

      final response = await request(accesToken);
      if (response.statusCode == HttpStatus.unauthorized) {
        final newTokens = await _getAccessToken(refreshToken);
        if (newTokens == null) {
          return left(UnAuntHorizedfail());
        }

        final storeResult = await storeAuthTokens(
          authTokens: newTokens,
        );
        if (storeResult.isLeft()) {
          return left(UnkonwFailure("Token saklanamadı"));
        }
        final retryResponse = await request(newTokens.accessToken);
        return onResponse(retryResponse); // ikinci sonucu parse et
      }

      return onResponse(response);
    } catch (e) {
      return await exepciton(e);
    }
  }

  Future<Either<Failure, AuthTokens>> getAuthTokens() async {
    try {
      final accesnToken = await secureStroge.read(
        key: accessTokenKey,
      );
      final refreshToken = await secureStroge.read(
        key: refreshTokenKey,
      );

      if (accesnToken == null || refreshToken == null) {
        return left(NotFoundFailer());
      }

      return right(
        AuthTokens(
          refreshToken: refreshToken,
          accessToken: accesnToken,
        ),
      );
    } catch (e) {
      return left(UnkonwFailure(e.toString()));
    }
  }

  Future<Either<Failure, Unit>> storeAuthTokens({
    required AuthTokens authTokens,
  }) async {
    try {
      await secureStroge.write(
        key: accessTokenKey,
        value: authTokens.accessToken,
      );
      await secureStroge.write(
        key: refreshTokenKey,
        value: authTokens.refreshToken,
      );

      return right(unit);
    } catch (e) {
      return left(UnkonwFailure(e.toString()));
    }
  }

  Future<String> getUniqueDeviceKey() async {
    var deviceKey = await secureStroge.read(key: deviceIdKey);
    if (deviceKey == null) {
      deviceKey = uuid.v4();
      await secureStroge.write(key: deviceIdKey, value: deviceKey);
    }
    return deviceKey;
  }
}
