import 'package:dartz/dartz.dart';
import 'package:saglixen/domain/auth/user_model.dart';
import 'package:saglixen/domain/failure/failure.dart';

abstract class IAuthClient {
  Future<Either<Failure, Unit>> loginAnonymus();
  Future<Either<Failure, UserModel>> getUser();
}
