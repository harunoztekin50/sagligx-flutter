import 'package:equatable/equatable.dart';

sealed class Failure extends Equatable {
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

class NotFoundFailer extends Failure {
  const NotFoundFailer();

  @override
  List<Object?> get props => [];
}

class TimeoutFailure extends Failure {
  const TimeoutFailure();
  @override
  List<Object?> get props => [];
}
