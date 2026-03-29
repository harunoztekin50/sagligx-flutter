part of 'auth_cubit.dart';

final class AuthCubitState extends Equatable {
  const AuthCubitState({
    required this.userOption,
    required this.singInFailOption,
    required this.isSingingIn,
  });

  final Option<UserModel> userOption;
  final Option<Failure> singInFailOption;
  final bool isSingingIn;

  factory AuthCubitState.initial() {
    return AuthCubitState(
      userOption: None(),
      singInFailOption: None(),
      isSingingIn: false,
    );
  }

  AuthCubitState copyWith({
    Option<UserModel>? userOption,
    Option<Failure>? singInFailOption,
    bool? isSingingIn,
  }) {
    return AuthCubitState(
      userOption: userOption ?? this.userOption,
      singInFailOption: singInFailOption ?? this.singInFailOption,
      isSingingIn: isSingingIn ?? this.isSingingIn,
    );
  }

  @override
  List<Object?> get props => [userOption, singInFailOption, isSingingIn];
}
