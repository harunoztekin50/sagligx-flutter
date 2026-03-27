import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:saglixen/domain/auth/auth_tokens_model.dart';
import 'package:saglixen/domain/auth/i_auth_client.dart';
import 'package:saglixen/domain/auth/user_model.dart';
import 'package:saglixen/domain/failure/failure.dart';
import 'package:saglixen/infrastructure/auth/auth_mixin.dart';
import 'package:uuid/uuid.dart';

class AuthClient extends Equatable with AuthMixin implements IAuthClient {
  final Client _client;
  final FlutterSecureStorage _secureStroage;
  final Uuid _uuid;

  static const deviceIdKey = "device_id";
  static const refreshTokenKey = "refresh_token";
  static const accessToken = "access_token";
  static const Map<String, String> headers = {'Content-Type': 'application/json'};

  const AuthClient({
    required Client client,
    required FlutterSecureStorage secureStroage,
    required Uuid uuid,
  }) : _client = client,
       _secureStroage = secureStroage,
       _uuid = uuid;

  @override
  Future<Either<Failure, Unit>> loginAnonymus() async {
    final deviceKey = await getUniqueDeviceKey();
    try {
      final response = await _client.post(
        Uri.parse(loginAnonymusUri),
        headers: headers,
        body: jsonEncode({"device_key": deviceKey}),
      );

      if (response.statusCode == HttpStatus.ok) {
        final body = jsonDecode(response.body) as Map<String, dynamic>;
        return storeAuthTokens(authTokens: AuthTokens.fromMap(body));
      } else if (response.statusCode == HttpStatus.unauthorized) {
        return left(UnAuntHorizedfail());
      } else {
        return left(UnkonwFailure(response.statusCode.toString()));
      }
    } on SocketException catch (_) {
      return left(NetworkFailure());
    } catch (e) {
      return left(UnkonwFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> getUser() {}

  @override
  List<Object?> get props => [];

  @override
  Client get client => _client;

  @override
  FlutterSecureStorage get secureStroge => _secureStroage;

  @override
  Uuid get uuid => _uuid;
}

const String loginAnonymusUri = ("http://localhost:8989/v1/auth/login/anonymus");
