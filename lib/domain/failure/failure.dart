import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure();
}

class UnkonwFailure extends Failure {
  final String? message;
  const UnkonwFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class UnAuntHorizedfail extends Failure {
  const UnAuntHorizedfail();

  @override
  List<Object?> get props => [];
}

class NetworkFailure extends Failure {
  const NetworkFailure();

  @override
  List<Object?> get props => [];
}
