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
      final response = await client.post(
        Uri.parse("http://10.0.2.2:8989/v1/auth/login/anonymus"),
        headers: {'Content-Type': 'application/json; charset=utf-8'},
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
  Future<Either<Failure, UserModel>> getUser() {
    return sendRequestWithToken(
      (accessToken) async {
        return await client.get(
          Uri.parse("http:localhost:8989/v1/auth/user"),
          headers: {'Authorization: Bearer': accessToken},
        );
      },
      (response) async {
        if (response.statusCode == HttpStatus.unauthorized) {
          return left(UnAuntHorizedfail());
        } else if (response.statusCode == HttpStatus.notFound) {
          return Left(NotFoundFailer());
        } else {
          return left(UnkonwFailure(response.statusCode.toString()));
        }
      },
      (onExpetion) async {
        if (onExpetion is SocketException) {
          return left(NetworkFailure());
        } else {
          return left(UnkonwFailure(onExpetion.toString()));
        }
      },
    );
  }

  @override
  List<Object?> get props => [];

  @override
  Client get client => _client;

  @override
  FlutterSecureStorage get secureStroge => _secureStroage;

  @override
  Uuid get uuid => _uuid;
}
