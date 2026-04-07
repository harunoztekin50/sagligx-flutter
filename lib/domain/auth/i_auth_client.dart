import 'package:dartz/dartz.dart';
import 'package:saglixen/core/failure/failure.dart';
import 'package:saglixen/domain/auth/auth_tokens_model.dart';
import 'package:saglixen/domain/auth/user_model.dart';

abstract class IAuthClient {
  Future<Either<Failure, Unit>> loginAnonymus();
  Future<Either<Failure, UserModel>> getUser();
  Future<Either<Failure, Unit>> logOut();
  Future<Either<Failure, AuthTokens>> getStoreAuthTokens();
}
