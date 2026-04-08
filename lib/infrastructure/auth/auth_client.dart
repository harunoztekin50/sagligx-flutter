import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:saglixen/core/contants/api_endpoints.dart';
import 'package:saglixen/core/failure/failure.dart';
import 'package:saglixen/domain/auth/auth_tokens_model.dart';
import 'package:saglixen/domain/auth/i_auth_client.dart';
import 'package:saglixen/domain/auth/user_model.dart';
import 'package:saglixen/infrastructure/auth/auth_mixin.dart';
import 'package:uuid/uuid.dart';

class AuthClient extends IAuthClient with AuthMixin {
  final Client _client;
  final FlutterSecureStorage _secureStroage;
  final Uuid _uuid;

  AuthClient({
    required Client client,
    required FlutterSecureStorage secureStroage,
    required Uuid uuid,
  }) : _client = client,
       _secureStroage = secureStroage,
       _uuid = uuid;

  @override
  Future<Either<Failure, Unit>> loginAnonymus() async {
    debugPrint('CLIENT: loginAnonymus başladı');

    final deviceKey = await getUniqueDeviceKey();
    debugPrint('CLIENT: deviceKey=$deviceKey');

    try {
      debugPrint(
        'CLIENT: istek atılıyor → ${ApiEndpoints.anonymousLogin}',
      );

      final response = await client.post(
        ApiEndpoints.anonymousLogin,
        headers: {'Content-Type': 'application/json; charset=utf-8'},
        body: jsonEncode({"device_key": deviceKey}),
      );
      debugPrint(
        'CLIENT: response=${response.statusCode} ${response.body}',
      );

      if (response.statusCode == HttpStatus.ok) {
        debugPrint(
          'LOGIN RESPONSE: ${response.body}',
        ); // ← bunu paylaş

        final body =
            jsonDecode(response.body) as Map<String, dynamic>;
        return storeAuthTokens(authTokens: AuthTokens.fromMap(body));
      }
      return Left(mapStatusToFailure(response.statusCode));
    } on SocketException catch (_) {
      return left(NetworkFailure());
    } catch (e) {
      return left(UnkonwFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> getUser() {
    return sendRequestWithToken(
      (accessToken) async {
        return await client.get(
          ApiEndpoints.user,
          headers: {'Authorization': 'Bearer $accessToken'},
        );
      },
      (response) async {
        if (response.statusCode == HttpStatus.ok) {
          final body =
              jsonDecode(response.body) as Map<String, dynamic>;
          return right(UserModel.fromJson(body));
        }
        return Left(mapStatusToFailure(response.statusCode));
      },
      (onExpetion) async {
        return Left(mapExceptionToFailure(onExpetion));
      },
    );
  }

  @override
  Future<Either<Failure, Unit>> logOut() async {
    final deviceKey = await _secureStroage.read(
      key: AuthMixin.deviceIdKey,
    );

    if (deviceKey == null) {
      return Left(NotFoundFailer());
    }

    return sendRequestWithToken(
      (accessToken) async {
        return await client.post(
          ApiEndpoints.logout,
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type':
                'application/json; charset=utf-8', // ← ekle
          },
          body: jsonEncode({"device_key": deviceKey}),
        );
      },
      (response) async {
        debugPrint(
          'RESPONSE: ${response.statusCode} ${response.body}',
        );

        if (response.statusCode == HttpStatus.ok) {
          return remoweAuthTokens();
        }
        return left(mapStatusToFailure(response.statusCode));
      },
      (onExpetion) async {
        return Left(mapExceptionToFailure(onExpetion));
      },
    );
  }

  @override
  Future<Either<Failure, AuthTokens>> getStoreAuthTokens() async {
    return await getAuthTokens();
  }

  @override
  Client get client => _client;

  @override
  FlutterSecureStorage get secureStroge => _secureStroage;

  @override
  Uuid get uuid => _uuid;
}
