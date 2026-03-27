part of 'auth_cubit.dart';

final class AuthCubitState extends Equatable {
  const AuthCubitState({required this.userOption, required this.singInFailOption});

  final Option<UserModel> userOption;
  final Option<Failure> singInFailOption;

  factory AuthCubitState.initial() {
    return AuthCubitState(userOption: None(), singInFailOption: None());
  }

  AuthCubitState copyWith({Option<UserModel>? userOption, Option<Failure>? singInFailOption}) {
    return AuthCubitState(
      userOption: userOption ?? this.userOption,
      singInFailOption: singInFailOption ?? this.singInFailOption,
    );
  }

  @override
  List<Object?> get props => [userOption, singInFailOption];
}
